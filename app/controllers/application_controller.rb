class ApplicationController < ActionController::Base

  helper_method :current_shop
  helper_method :is_user_role_vendor?
  helper_method :is_user_role_admin?
  helper_method :current_vendor

  protected

    def current_shop
      return nil unless user_signed_in?
      current_user.shop
    end

    def is_user_role_vendor?
      return false unless user_signed_in?
      current_user.is_role_vendor?
    end

    def is_user_role_admin?
      return false unless user_signed_in?
      current_user.is_role_admin?
    end

    def current_vendor
      return nil unless is_user_role_vendor?
      return current_user.vendor
    end

    def ensure_current_user_in_vendor_role!
      unless is_user_role_vendor?
        render not_found
      end
    end

    def ensure_current_user_in_admin_role!
      unless is_user_role_admin?
        render not_found
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
