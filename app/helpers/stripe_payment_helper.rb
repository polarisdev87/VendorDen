module StripePaymentHelper

  def connect_vendor_with_stripe_button(vendor)
    img = image_tag('stripe-button-blue-on-light.png') 
    link_url = "https://connect.stripe.com/express/oauth/authorize"
    link_params = {
      'redirect_uri'               => stripe_vendor_connect_callback_url,
      'client_id'                  => ENV['STRIPE_CLIENT_ID'],
      'state'                      => vendor.id,
      'stripe_user[business_name]' => vendor.business_name,
      'stripe_user[email]'         => vendor.email,
      'stripe_user[first_name]'    => vendor.poc_first_name,
      'stripe_user[last_name]'     => vendor.poc_last_name,
      'stripe_user[phone_number]'  => vendor.phone_number
    }
    link_to(img, "#{link_url}?#{link_params.to_param}")
  end

  def connect_admin_with_stripe_button
    img = image_tag('stripe-button-blue-on-light.png') 
    link_url = "https://connect.stripe.com/express/oauth/authorize"
    link_params = {
      'redirect_uri'               => stripe_admin_connect_callback_url,
      'client_id'                  => ENV['STRIPE_CLIENT_ID'],
      'state'                      => current_shop.id
    }
    link = "#{link_url}?#{link_params.to_param}"
    %{
      <buttton onclick="window.open('#{link}')">
        #{img}
      </button>
    }.html_safe
  end
end
