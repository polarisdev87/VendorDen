class Stripe::Webhooks::Account::FallbackJob < ApplicationJob
  queue_as :stripe
 
  def perform(job_args)

  end
end
