class AdminsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_current_user_in_admin_role!


  def show
    redirect_to dashboard_admin_path
  end

  def dashboard
    active_vendors = current_shop.vendors.active
    @new_time_slot = current_shop.time_slots.build
    @new_product = current_shop.products.build
    @vendor_invites = current_shop.vendor_invites
    @vendors = current_shop.vendors
    @products = current_shop.products
    @payouts = current_shop.payouts.includes(:vendor)

    @sales_total = ActionController::Base.helpers.number_to_currency(current_shop.payouts.sum(:amount_sold))
    @commission_total = ActionController::Base.helpers.number_to_currency(current_shop.payouts.sum(:amount_commissions_earned))

    @payouts_unpaid = ActionController::Base.helpers.number_to_currency(current_shop.payouts.unpaid.sum(:amount_to_be_paid_out))
    @payouts_paid = ActionController::Base.helpers.number_to_currency(current_shop.payouts.paid.sum(:amount_to_be_paid_out))
    @payouts_total = ActionController::Base.helpers.number_to_currency(current_shop.payouts.sum(:amount_to_be_paid_out))

    @product_sales_title = "#{Time.zone.now.strftime('%B %Y')} Product Sales"
    @product_sales_report_data = current_shop.generate_product_sales_report_data

    @product_commissions_earned_title = "#{Time.zone.now.strftime('%B %Y')} Product Commissions Earned"
    @product_commissions_earned_report_data = current_shop.generate_product_commissions_earned_report_data

  end
end
