class Payout < ApplicationRecord
 
  #--------------------------------------------------------------------
  # Constants
  #--------------------------------------------------------------------
  UNPAID_STATUS = 'unpaid'
  PAID_STATUS = 'paid'
  STATUSES = [
    UNPAID_STATUS,
    PAID_STATUS
  ]

  MANUAL_PAYMENT_TYPE = 'manual'
  STRIPE_PAYMENT_TYPE = 'stripe'
  PAYMENT_TYPES = [
    MANUAL_PAYMENT_TYPE,
    STRIPE_PAYMENT_TYPE
  ]

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  belongs_to :vendor
  belongs_to :product

  #--------------------------------------------------------------------
  # Scopes
  #--------------------------------------------------------------------
  scope :unpaid, -> { where(status: UNPAID_STATUS) }
  scope :paid, -> { where(status: PAID_STATUS) }

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :status, presence: true, inclusion: { in: STATUSES }

  #--------------------------------------------------------------------
  # Callbacks
  #--------------------------------------------------------------------
  after_initialize  :set_status
  before_validation :set_shop

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def is_unpaid?
    self.status == UNPAID_STATUS
  end

  def manual_payment!
    update_attributes!({
      status: PAID_STATUS,
      payment_type: MANUAL_PAYMENT_TYPE
    })
  end

  def stripe_payment!
    charge = Stripe::Charge.create({
      :amount => (self.amount_to_be_paid_out * 100).to_i,
      :currency => "usd",
      :on_behalf_of => self.shop.setting.stripe_account_id
    })
    transfer = Stripe::Transfer.create({
      :amount => (self.amount_to_be_paid_out * 100).to_i,
      :currency => "usd",
      :source_transaction => charge.id,
      :destination => self.vendor.stripe_account_id,
    })
    update_attributes!({
      status: PAID_STATUS,
      payment_type: STRIPE_PAYMENT_TYPE
    })
  end

  private

    def set_status
      if self.status.blank?
        self.status = UNPAID_STATUS
      end
    end

    def set_shop
      self.shop = self.vendor.shop
    end
end
