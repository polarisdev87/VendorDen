class VendorsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user_in_vendor_role!

  def show
    redirect_to dashboard_vendor_path
  end

  def dashboard
    @unpaid_payouts = current_vendor.payouts.unpaid
    @products = current_vendor.products
    @unfulfilled_orders_count = current_vendor.unfulfilled_shopify_orders.length
    @orders_count = current_vendor.shopify_orders.length
    @products_count = @products.length
    @payouts_paid = ActionController::Base.helpers.number_to_currency(current_vendor.payouts.paid.sum(:amount_to_be_paid_out).round(2))
    @payouts_receivable = ActionController::Base.helpers.number_to_currency(current_vendor.payouts.unpaid.sum(:amount_to_be_paid_out).round(2))
    @total_payouts = ActionController::Base.helpers.number_to_currency(current_vendor.payouts.sum(:amount_to_be_paid_out).round(2))
    @payouts_report_title = Time.zone.now.strftime('%B %Y')
    @payouts_report_data = current_vendor.generate_payouts_report_data
  end

  def calendar

  end

  def bookings
    @bookings = current_vendor.bookings
    respond_to do |format|
      format.json
    end
  end

  def products
    @products = current_vendor.products
  end
  
  def orders
    @orders = current_vendor.shopify_orders
  end
  
  def payouts
    @payouts = current_vendor.payouts
  end
  
  def settings

  end
end

