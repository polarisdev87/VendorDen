class Shopify::Webhooks::CartsCreateJob < ApplicationJob
  queue_as :shopify
 
  def perform(job_args)
    # DO NOTHING
  end
end
