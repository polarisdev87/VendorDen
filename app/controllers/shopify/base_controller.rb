class Shopify::BaseController < ShopifyApp::AuthenticatedController

  before_action :check_prerequisites!

  helper :all
  helper_method :current_shop

  protected

    def current_shop
      Shop.find_by_shopify_domain!(current_shopify_domain)
    end

  private

    def check_prerequisites!
      if current_shop.has_no_admin_user?
        redirect_to shopify_admin_user_setup_path
      elsif not current_shop.has_payment_info?
        redirect_to shopify_payment_setup_path
      end
    end
end
