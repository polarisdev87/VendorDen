module Product::ShopifyConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def shopify_product
    @shopify_product ||= self.shop.shopify_session { ShopifyAPI::Product.find(self.shopify_id) }
    ShopifyProduct.new(shop, @shopify_product)
  rescue
    nil
  end
end
