module Shop::BookingProcessingConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def process_bookings_from_webhook!(webhook)
    return unless %w[authorization].include?(webhook[:kind])
    shopify_session do
      
      order = ShopifyAPI::Order.find(webhook[:order_id])
      if order.present?
        order.line_items.each do |line_item|
          product = self.products.find_by_shopify_id(line_item.product_id)

          next unless product.is_bookable?

          from_date = line_item.properties.select { |p| p.name == 'from_date' }.first.value
          from_time = line_item.properties.select { |p| p.name == 'from_time' }.first.value
          to_date = line_item.properties.select { |p| p.name == 'to_date' }.first.value
          to_time = line_item.properties.select { |p| p.name == 'to_time' }.first.value
          
          Booking.create!({
            product_id: product.id,
            vendor_id: product.vendor.id,
            shop_id: product.shop.id,
            start_date: from_date,
            start_time: from_time,
            end_date: to_date,
            end_time: to_time,
            shopify_order_id: order.id,
            shopify_customer_name: "#{order.customer.first_name} #{order.customer.last_name}",
            shopify_order_line_item_id: line_item.id
          })
        end
      end
    end
  end
end
