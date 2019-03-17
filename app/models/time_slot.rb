class TimeSlot < ApplicationRecord

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop

  has_many :product_bookings
  has_many :products, through: :product_bookings

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :description, presence: true, 
                          uniqueness: {scope: 'shop_id'}

  validate  :start_time_and_end_time_must_not_exists
  validate  :start_at_must_not_overlap_with_previous_end_at
  validate  :end_at_must_not_overlap_with_next_start_at

  #--------------------------------------------------------------------
  # Scopes
  #--------------------------------------------------------------------
  scope :unbooked, -> { where("not (time_slots.id in (select pb.time_slot_id from product_bookings pb))") }

  #--------------------------------------------------------------------
  # Callbacks
  #--------------------------------------------------------------------
  after_initialize  :setup_start_date
  after_initialize  :setup_start_time
  after_initialize  :setup_end_date
  after_initialize  :setup_end_time

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Concerns::CalendarableModelConcern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def display
    "#{self.description} [#{self.start_at.strftime('%Y-%m-%d %I:%M %p')} to #{self.end_at.strftime('%Y-%m-%d %I:%M %p')}]"
  end

  private

    def setup_start_date
      return if self.start_at.present? || self.start_date.present?
      self.start_date = Time.zone.now.strftime('%Y-%m-%d')
    end

    def setup_start_time
      return if self.start_at.present? || self.start_time.present?
      self.start_time = '08:00'
    end

    def setup_end_date
      return if self.end_at.present? || self.end_date.present?
      self.end_date = Time.zone.now.strftime('%Y-%m-%d')
    end

    def setup_end_time
      return if self.end_at.present? || self.end_time.present?
      self.end_time = '17:00'
    end

    def start_time_and_end_time_must_not_exists
      return if self.start_at.blank?
      return if self.end_at.blank?
      query = [
        "(start_at = :start_at and end_at = :end_at) and id <> :id", 
        {
          id: (self.id.present? ? self.id : -1),
          start_at: self.start_at,
          end_at: self.end_at
        }
      ]
      if shop.time_slots.where(query).exists?
        overlapped_time_slot = shop.time_slots.where(query).first
        overlapped_time_slot_description = overlapped_time_slot.description
        overlapped_time_slot_end_at = overlapped_time_slot.end_at.strftime('%I:%M %p')
        self.errors.add(:start_time, "overlaps [#{overlapped_time_slot_description}].")
      end
    end

    def start_at_must_not_overlap_with_previous_end_at
      return if self.start_at.blank?
      if is_all_day?
        #TODO: handle all day logic
      else
        query = [
          "(end_at > :start_at and start_at < :start_at) and id <> :id", 
          {
            id: (self.id.present? ? self.id : -1),
            start_at: self.start_at
          }
        ]
        if shop.time_slots.where(query).exists?
          overlapped_time_slot = shop.time_slots.where(query).first
          overlapped_time_slot_description = overlapped_time_slot.description
          overlapped_time_slot_end_at = overlapped_time_slot.end_at.strftime('%I:%M %p')
          self.errors.add(:start_time, "overlaps [#{overlapped_time_slot_description}] end time at #{overlapped_time_slot_end_at}.")
        end
      end
    end

    def end_at_must_not_overlap_with_next_start_at
      return if self.end_at.blank?
      if is_all_day?
        #TODO: handle all day logic
      else
        query = [
          "(start_at < :end_at and end_at > :end_at) and id <> :id", 
          {
            id: (self.id.present? ? self.id : -1),
            end_at: self.end_at
          }
        ]
        if shop.time_slots.where(query).exists?
          overlapped_time_slot = shop.time_slots.where(query).first
          overlapped_time_slot_description = overlapped_time_slot.description
          overlapped_time_slot_start_at = overlapped_time_slot.start_at.strftime('%I:%M %p')
          self.errors.add(:end_time, "overlaps [#{overlapped_time_slot_description}] start time at #{overlapped_time_slot_start_at}.")
        end
      end
    end
end
