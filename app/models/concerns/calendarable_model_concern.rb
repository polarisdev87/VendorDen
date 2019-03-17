module Concerns::CalendarableModelConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Constants
  #--------------------------------------------------------------------
  TIME_INPUT_PATTERN = /\A\d{1,2}\:\d{2}(\ [a|A|p|P][m|M])?\z/

  included do
    validates :start_date, presence: true
    validates :start_time, format: {with: TIME_INPUT_PATTERN, allow_blank: true}
    validates :end_date, presence: true
    validates :end_time, format: {with: TIME_INPUT_PATTERN, allow_blank: true}

    validate  :end_time_must_be_greater_than_start_time

    before_validation :set_start_at
    before_validation :set_end_at
  end

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  
  protected

    def set_start_at
      self.start_at = Time.zone.parse("#{self.start_date} #{self.start_time}")
    end

    def set_end_at
      self.end_at = Time.zone.parse("#{self.end_date} #{self.end_time}")
    end

    def end_time_must_be_greater_than_start_time
      
      return if self.start_at.blank?
      return if self.end_at.blank?

      if self.start_at >= self.end_at
        if self.start_at.strftime('%Y%m%d') == self.end_at.strftime('%Y%m%d')
          self.errors.add(:end_time, 'must be greater than start time')
        else
          self.errors.add(:end_date, 'must be greater than start date')
        end
      end
    end
end
