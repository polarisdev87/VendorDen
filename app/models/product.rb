class Product < ApplicationRecord

  BOOKED_CLASS_PRODUCT_TYPE = 'Booked Class'

  AMOUNT_COMMISSION_STRUCTURE_TYPE = '$'
  PERCENTAGE_COMMISSION_STRUCTURE_TYPE = '%'
  COMMISSION_STRUCTURE_TYPES = [
    AMOUNT_COMMISSION_STRUCTURE_TYPE,
    PERCENTAGE_COMMISSION_STRUCTURE_TYPE
  ]

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  belongs_to :vendor

  has_many :product_bookings
  has_many :time_slots, through: :product_bookings
  
  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :title, presence: true
  validates :cost_of_goods, presence: true
  validates :minimum_commission_per_product, presence: true
  validates :commission_structure_type, presence: true,
                                        inclusion: { in: COMMISSION_STRUCTURE_TYPES }

  #--------------------------------------------------------------------
  # Callbacks
  #--------------------------------------------------------------------
  after_initialize :set_minimum_commission_per_product
  after_initialize :set_commission_structure_type

  before_validation :set_time_slots_based_on_time_slot_ids

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Product::ShopifyConcern
  include Product::ShopifySyncingConcern
  include Product::CommissionSplittingConcern
  
  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def time_slot_ids
    @time_slot_ids || []
  end

  def time_slot_ids=(values)
    @time_slot_ids = values.map(&:to_i).reject { |i| i < 1 }
  end

  def commission_structure_type_amount?
    self.commission_structure_type == AMOUNT_COMMISSION_STRUCTURE_TYPE
  end

  def commission_structure_type_percentage?
    self.commission_structure_type == PERCENTAGE_COMMISSION_STRUCTURE_TYPE
  end

  def commision_display
    if commission_structure_type_amount?
      "#{minimum_commission_per_product} USD per product or time schedule booking"
    elsif commission_structure_type_percentage?
      "#{minimum_commission_per_product}% per product or time schedule booking"
    else
      ''
    end
  end

  def set_shopify_product!(shopify_product)
    @shopify_product = shopify_product
    self.shopify_id = @shopify_product.id
    self.title = @shopify_product.title
  end

  def inventory_quantity
    sp = self.shopify_product
    if sp.is_physical_product?
      sp.variants.first.inventory_quantity rescue 0
    else
      nil
    end
  end

  def is_physical_product?
    self.shopify_product.is_physical_product?
  end

    private

      def set_time_slots_based_on_time_slot_ids
        return if time_slot_ids.blank?
        self.time_slots = time_slot_ids.map { |time_slot_id| shop.time_slots.find(time_slot_id) }
      end

      def set_minimum_commission_per_product
        return unless self.minimum_commission_per_product.blank?
        self.minimum_commission_per_product = self.shop.setting.minimum_commission_per_product
      end

      def set_commission_structure_type
        return unless self.commission_structure_type.blank?
        self.commission_structure_type = self.shop.setting.structure_type
      end
end
