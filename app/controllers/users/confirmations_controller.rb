module Users

  class ConfirmationsController < Devise::ConfirmationsController

    def show
      super do |user|
        if user.is_role_vendor?
          vendor_invite = VendorInvite.for_user(user)
          vendor_invite.set_status_to_invite_accepted!
        end
      end
    end

    protected

      def after_confirmation_path_for(resource_name, user)
        if user.is_role_vendor?
          sign_in(resource_name, user)
          vendor_invite = VendorInvite.for_user(user)
          if vendor_invite.user.has_no_password?
            set_password_vendor_invite_wizard_path
          elsif vendor_invite.is_vendor_info_incomplete?
            complete_info_vendor_invite_wizard_path
          elsif vendor_invite.is_payment_info_incomplete?
            payment_info_vendor_invite_wizard_path
          else
            dashboard_vendor_path
          end
        else
          super
        end
      end 
  end
end
