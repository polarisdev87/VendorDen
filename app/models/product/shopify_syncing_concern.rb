module Product::ShopifySyncingConcern
  extend ActiveSupport::Concern

  included do
    #------------------------------------------------------------------
    # Callbacks
    #------------------------------------------------------------------
    after_save  :update_shopify_product_variants
  end

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def skip_sync_to_shopify!
    @skip_sync_to_shopify = true
  end

  def skip_sync_to_shopify?
    @skip_sync_to_shopify
  end

  def sync_update_from_shopify_webhook(webhook)

    update_columns({
      title: webhook[:title]
    })
  end

  private

    def update_shopify_product_variants
      return if skip_sync_to_shopify?
      shop.shopify_session do
        prod = ShopifyAPI::Product.find(shopify_id)
        prod.vendor = self.vendor.business_name
        prod.save
      end
    end
end
