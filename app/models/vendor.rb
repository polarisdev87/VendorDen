class Vendor < ApplicationRecord
  #--------------------------------------------------------------------
  # Constants
  #--------------------------------------------------------------------
  ACTIVE_STATUS = 'Active'

  #--------------------------------------------------------------------
  # Attributes
  #--------------------------------------------------------------------
  alias_attribute :name, :business_name

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  belongs_to :user, optional: true
  has_many :products
  has_many :bookings
  has_many :payouts

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :email, presence: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, 
                    uniqueness: {scope: 'shop_id'}

  validates :business_name, presence: true, uniqueness: {scope: 'shop_id', allow_blank: true}                   
  validates :tax_id, presence: true                   
  validates :poc_first_name, presence: true                   
  validates :poc_last_name, presence: true                   
  validates :phone_number, presence: true
  validates :status, presence: true

  #--------------------------------------------------------------------
  # Scopes
  #--------------------------------------------------------------------
  scope :active, -> { where(:status => ACTIVE_STATUS) }

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Concerns::StripeConcern
  include Vendor::ReportDataGeneratorConcern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def shopify_orders
    self.bookings.map { |booking| booking.shopify_order }
  end

  def unfulfilled_shopify_orders
    shopify_orders.select { |o| o.fulfillment_status.blank? }
  end

  def change_status
    if self.status == "Active"
      self.status = "Inactive"
      self.save
    else
      self.status = "Active"
      self.save
    end
  end
end
