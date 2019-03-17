class Shopify::Webhooks::CartsUpdateJob < ApplicationJob
  queue_as :shopify
 
  def perform(job_args)
    # DO NOTHING
  end
end
