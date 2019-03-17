class ShopifyProduct
  include ActiveModel::Model

  attr_reader :shop, :product

  def initialize(shop, shopify_api_product)
    @shop = shop
    @shopify_api_product = shopify_api_product
    @product = shop.products.where(shopify_id: @shopify_api_product.id).take
  end

  def is_booked?
    @product.present?
  end
      
  def is_physical_product?
    is_inventory_management?
  end    



  def method_missing(m, *args, &block)  
    @shopify_api_product.send(m, *args, &block)
  rescue NoMethodError
    super
  end 

  private

    def is_inventory_management?
      variants.first.inventory_management.present?
    end
end
