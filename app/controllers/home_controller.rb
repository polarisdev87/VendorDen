class HomeController < ApplicationController

  layout false

  before_action :redirect_to_dashboard_according_to_user_role, only: %i[index]

  def index
  end

  private

    def redirect_to_dashboard_according_to_user_role
      if is_user_role_vendor?
        redirect_to dashboard_vendor_path
      elsif is_user_role_admin?
        redirect_to dashboard_admin_path
      end
    end
end
