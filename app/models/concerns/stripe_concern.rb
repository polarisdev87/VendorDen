module Concerns::StripeConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def update_stripe_account_id!(stripe_account_id)
    self.update_attributes!(stripe_account_id: stripe_account_id)
  end

  def has_stripe_account?
    self.stripe_account_id.present?
  end
  alias_method :has_payment_info?, :has_stripe_account?
end
