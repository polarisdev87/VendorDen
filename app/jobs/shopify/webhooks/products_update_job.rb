class Shopify::Webhooks::ProductsUpdateJob < ApplicationJob
  queue_as :shopify
 
  def perform(job_args)
    shop_domain = job_args[:shop_domain]
    webhook = job_args[:webhook]
    shop = Shop.find_by_shopify_domain!(shop_domain)
    product = shop.products.where(shopify_id: webhook[:id]).take
    if product.present?
      product.skip_sync_to_shopify!
      product.sync_update_from_shopify_webhook(webhook)
    end
  end
end
