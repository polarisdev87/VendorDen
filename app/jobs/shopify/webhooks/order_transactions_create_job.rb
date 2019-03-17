class Shopify::Webhooks::OrderTransactionsCreateJob < ApplicationJob
  queue_as :shopify
 
  def perform(job_args)
    shop_domain = job_args[:shop_domain]
    webhook = job_args[:webhook]
    shop = Shop.find_by_shopify_domain!(shop_domain)
    shop.process_bookings_from_webhook!(webhook)
    shop.process_payouts_from_webhook!(webhook)
  end
end
