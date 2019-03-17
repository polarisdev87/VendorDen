class VendorInviteError < StandardError; end

class VendorInvite < ApplicationRecord

  #--------------------------------------------------------------------
  # Constants
  #--------------------------------------------------------------------
  INVITE_SENT_STATUS = 'invite_sent'
  INVITE_ACCEPTED_STATUS = 'invite_accepted'
  STATUSES = [
    INVITE_SENT_STATUS,
    INVITE_ACCEPTED_STATUS
  ]

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  belongs_to :user, optional: true
  belongs_to :vendor, optional: true

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :email, presence: true, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, 
                    uniqueness: {scope: 'shop_id'}

  #--------------------------------------------------------------------
  # Callbacks
  #--------------------------------------------------------------------
  before_create :create_user
  before_create :set_status_to_invite_sent

  #--------------------------------------------------------------------
  # Class Methods
  #--------------------------------------------------------------------
  class << self

    def for_user(user)
      where(shop_id: user.shop_id, user_id: user.id).take!
    end

    def related_vendor(user)
      where(shop_id: user.shop_id, user_id: user.id, status: INVITE_ACCEPTED_STATUS).take!.vendor
    end
  end

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def can_cancel?
    not [INVITE_ACCEPTED_STATUS].include?(self.status)
  end

  def cancel!
    raise VendorInviteError, "Invatation was already accepted!" unless can_cancel?
    ActiveRecord::Base.transaction do
      self.user.destroy!
      self.vendor.destroy! if self.vendor.present?
      self.destroy!
    end
  end

  def build_vendor(vendor_params = {})
    shop.vendors.build(vendor_params.merge(email: self.email, user_id: self.user_id))
  end

  def set_status_to_invite_accepted!
    update_attributes!({
      status: INVITE_ACCEPTED_STATUS,
      accepted_at: Time.zone.now
    })
  end

  def is_status_invite_accepted?
    self.status == INVITE_ACCEPTED_STATUS
  end

  def is_vendor_info_incomplete?
    self.vendor.nil?
  end

  def is_payment_info_incomplete?
    is_vendor_info_incomplete? or not has_payment_info?
  end

  private

    def create_user
      self.user = shop.users.create(email: self.email, role: User::VENDOR_ROLE)
    end

    def set_status_to_invite_sent
      self.status = INVITE_SENT_STATUS
    end
end
