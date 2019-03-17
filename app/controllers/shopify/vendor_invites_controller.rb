class Shopify::VendorInvitesController < Shopify::BaseController

  before_action :set_vendor_invite, only: %w[cancel]

  def index
    @vendor_invites = current_shop.vendor_invites
  end

  def new
    @vendor_invite = current_shop.vendor_invites.build
  end

  def create
    @vendor_invite = current_shop.vendor_invites.build(vendor_invite_params)
    if @vendor_invite.save
      redirect_to shopify_root_path('tab' => 'vendor_invites')
      flash.notice = "Invitation for vendor was sent to #{@vendor_invite.email}."
    else
      render :new
    end
  end

  def cancel
    if @vendor_invite.can_cancel?
      @vendor_invite.cancel!
      @vendor_invites = current_shop.vendor_invites
      respond_to do |format|
        format.js
      end
    else
      @vendor_invites = current_shop.vendor_invites
      respond_to do |format|
        format.js
      end
    end
  end

  private

    def set_vendor_invite
      @vendor_invite = current_shop.vendor_invites.find(params[:id])
    end

    def vendor_invite_params
      params.require(:vendor_invite).permit(
        :email
      )
    end
end
