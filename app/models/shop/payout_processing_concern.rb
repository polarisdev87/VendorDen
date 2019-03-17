module Shop::PayoutProcessingConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def process_payouts_from_webhook!(webhook)
    return unless %w[authorization capture sale].include?(webhook[:kind])
    shopify_session do
      order = ShopifyAPI::Order.find(webhook[:order_id])
      order.line_items.each do |line_item|
        product = self.products.where(shopify_id: line_item.product_id).take

        if product.present?
          cost_of_goods = product.cost_of_goods.to_f
          qty = line_item.quantity
          vendor = product.vendor
          amount_sold = cost_of_goods * qty
          amount_commissions_earned, amount_to_be_paid_out = product.calculate_commission_split_for_amount(amount_sold)
          payout = vendor.payouts.create!({
            amount_sold: amount_sold,
            amount_commissions_earned: amount_commissions_earned,
            amount_to_be_paid_out: amount_to_be_paid_out,
            product: product
          })
        end
      end
    end
  end
end
