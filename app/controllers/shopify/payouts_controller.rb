class Shopify::PayoutsController < Shopify::BaseController
	  
  before_action :set_payout, only: %i[manual_payment stripe_payment]

  def manual_payment
    @payout.manual_payment!
    respond_to do |format|
      format.js
    end
  end

  def stripe_payment
    @payout.stripe_payment!
    respond_to do |format|
      format.js
    end
  end

  private

    def set_payout
      @payout = current_shop.payouts.find(params[:id])
    end
end
