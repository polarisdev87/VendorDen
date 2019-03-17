ShopifyApp.configure do |config|
  config.application_name = "CD-Shopify"
  config.root_url = '/shopify/'
  config.api_key = ENV['SHOPIFY_CLIENT_API_KEY']
  config.secret = ENV['SHOPIFY_CLIENT_API_SECRET']
  config.scope = "read_orders, read_products, read_product_listings, write_products, write_script_tags, write_themes"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
  config.webhook_jobs_namespace = 'shopify/webhooks'
  config.webhooks = [
    {topic: 'app/uninstalled', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/app_uninstalled"},
    {topic: 'products/create', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/products_create"},
    {topic: 'products/delete', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/products_delete"},
    {topic: 'products/update', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/products_update"},
    {topic: 'products/delete', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/carts_create"},
    {topic: 'products/update', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/carts_update"},
    {topic: 'order_transactions/create', address: "#{ENV['SHOPIFY_APP_HOST']}/webhooks/order_transactions_create"}
  ] 
  config.scripttags = [
    {event:'onload', src: "#{ENV['HOST']}/shopify/scripttags/booking.js"},
    {event:'onload', src: "#{ENV['HOST']}/shopify/scripttags/client_calendar.js"}
  ]
end
