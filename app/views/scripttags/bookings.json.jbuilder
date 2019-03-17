json.array! @bookings do |booking|

  begin
    shopify_product = booking.product.shopify_product
    shopify_product_title = shopify_product.title
    shopify_product_images = shopify_product.images.map(&:src)
    first_shopify_product_image = shopify_product_images.first
  rescue
    shopify_product_title = ''
    shopify_product_images = []
    first_shopify_product_image = nil
  end

  json.id          booking.id
  json.title       booking.description
  json.start       booking.start_at.strftime('%FT%T%:z')
  json.end         booking.end_at.strftime('%FT%T%:z')
  json.className   'booking'
  json.has_images  shopify_product_images.present?
  json.image_urls  shopify_product_images
  json.image_url   first_shopify_product_image
  json.image_title shopify_product_title
end
