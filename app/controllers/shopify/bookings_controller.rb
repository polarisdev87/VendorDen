class Shopify::BookingsController < Shopify::BaseController

  def index
    @bookings = current_shop.bookings
  end
end
