json.array! @bookings do |booking|

  json.id        booking.id
  json.title     booking.description
  json.start     booking.start_at.strftime('%FT%T%:z')
  json.end       booking.end_at.strftime('%FT%T%:z')
  json.className 'booking'
  json.order_status_url booking.shopify_order.order_status_url

end
