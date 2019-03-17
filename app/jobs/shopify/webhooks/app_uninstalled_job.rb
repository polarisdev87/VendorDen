class Shopify::Webhooks::AppUninstalledJob < ApplicationJob
  queue_as :shopify
 
  def perform(job_args)
    shop_domain = job_args[:shop_domain]
    webhook = job_args[:webhook]
    shop = Shop.find_by_shopify_domain!(shop_domain)
    shop.destroy!
  end
end
