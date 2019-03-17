class StripeController < ApplicationController

  skip_before_action :verify_authenticity_token, only: %i[account_webhook connect_webhook]

  def vendor_connect_callback
    stripe_code = params[:code]
    vendor_id = params[:state]
    vendor = Vendor.find(vendor_id)
    client = Stripe::StripeClient.new
    resp, key = client.execute_request(
        :post, 
        '/oauth/token', 
        api_base: 'https://connect.stripe.com', 
        params: {code: stripe_code, grant_type: 'authorization_code'}
      )
    stripe_account_id = resp.data[:stripe_user_id]
    vendor.update_stripe_account_id!(stripe_account_id)
    flash[:notice] = "Payment info was successfully created."
    redirect_to dashboard_vendor_path
  end

  def admin_connect_callback
    stripe_code = params[:code]
    shop_id = params[:state]
    shop = Shop.find(shop_id)
    client = Stripe::StripeClient.new
    resp, key = client.execute_request(
        :post, 
        '/oauth/token', 
        api_base: 'https://connect.stripe.com', 
        params: {code: stripe_code, grant_type: 'authorization_code'}
      )
    stripe_account_id = resp.data[:stripe_user_id]
    shop.setting.update_stripe_account_id!(stripe_account_id)
    flash[:notice] = "Payment info was successfully created."
    redirect_to shopify_root_path(tab: 'settings')
  end

  def account_webhook
    clazz = webhook_job_class(:account)
    clazz.perform_later webhook_params
    head :ok
  end

  def connect_webhook
    clazz = webhook_job_class(:connect)
    clazz.perform_later webhook_params
    head :ok
  end

  private

    def webhook_job_class(type)
      webhook_params_type = params[:type]
      webhook_job_class = "Stripe::Webhooks::#{type.to_s.classify}::#{webhook_params_type.gsub('account.', '').gsub('.', '_').classify}Job"
      webhook_job = webhook_job_class.constantize
    rescue NameError
      "Stripe::Webhooks::#{type.to_s.classify}::FallbackJob".constantize
    end

    def webhook_params
      hash_params = params.to_unsafe_h
      hash_params.delete(:controller)
      hash_params.delete(:action)
      hash_params
    end
end
