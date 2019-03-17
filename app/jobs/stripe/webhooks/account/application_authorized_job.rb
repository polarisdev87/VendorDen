class Stripe::Webhooks::Account::ApplicationAuthorizedJob < ApplicationJob
  queue_as :stripe
 
  def perform(job_args)

  end
end
