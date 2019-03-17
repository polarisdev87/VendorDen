class Shopify::HomeController < Shopify::BaseController

  def index
  	@active_vendors = current_shop.vendors.active
  	@new_time_slot = current_shop.time_slots.build
    @new_product = current_shop.products.build
    @vendor_invites = current_shop.vendor_invites
    @vendors = current_shop.vendors
    @products = current_shop.products
    @unbooked_shopify_products = current_shop.unbooked_shopify_products
    @booked_shopify_products = current_shop.booked_shopify_products
    @payouts = current_shop.payouts.includes(:vendor)

    @sales_total = current_shop.payouts.sum(:amount_sold)
    @commission_total = current_shop.payouts.sum(:amount_commissions_earned)

    @payouts_unpaid = current_shop.payouts.unpaid.sum(:amount_to_be_paid_out)
    @payouts_paid = current_shop.payouts.paid.sum(:amount_to_be_paid_out)
    @payouts_total = current_shop.payouts.sum(:amount_to_be_paid_out)

    @product_sales_title = "#{Time.zone.now.strftime('%B %Y')} Product Sales"
    @product_sales_report_data = current_shop.generate_product_sales_report_data

    @product_commissions_earned_title = "#{Time.zone.now.strftime('%B %Y')} Product Commissions Earned"
    @product_commissions_earned_report_data = current_shop.generate_product_commissions_earned_report_data
  end
end
