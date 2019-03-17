module Booking::ShopifyConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def shopify_order
    @shopify_order ||= self.shop.shopify_session { ShopifyAPI::Order.find(self.shopify_order_id) }
  end
end
