class VendorInviteWizardsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_current_user_in_vendor_role!

  layout 'vendor_invite_wizards'

  def set_password
    if request.patch?
      do_set_password
    end
  end

  def complete_info
    @vendor_invite = VendorInvite.for_user(current_user)
    if request.post?
      @vendor = @vendor_invite.build_vendor(vendor_params)
      do_complete_info
    else
      @vendor = @vendor_invite.build_vendor
    end
  end

  def payment_info
    
  end

  private

    def do_set_password
      current_user.validate_password!
      if current_user.update_attributes(user_password_params)
        vendor_invite = VendorInvite.for_user(current_user)
        if vendor_invite.is_vendor_info_incomplete?
          redirect_to complete_info_vendor_invite_wizard_path
        elsif vendor_invite.is_payment_info_incomplete?
          redirect_to payment_info_vendor_invite_wizard_path
        else
          redirect_to dashboard_vendor_path(vendor_invite.vendor)
        end
      else
        render :set_password
      end
    end

    def do_complete_info
      if @vendor.save
        flash[:notice] = "Vendor info was successfully completed."
        redirect_to payment_info_vendor_invite_wizard_path
      else
        flash[:error] = "An error occurred and is unable to save."
      end
    end

    def user_password_params
      params.require(:user).permit(
        :password,
        :password_confirmation
      )
    end

    def vendor_params
      params.require(:vendor).permit(
        :business_name,
        :poc_first_name,
        :poc_last_name,
        :phone_number,
        :email,
        :tax_id,
        :address,
        :status
      )
    end
end
