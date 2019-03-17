class ScripttagsController < ApplicationController

  skip_before_action :verify_authenticity_token

  before_action :set_shop
  before_action :add_allow_credentials_headers

  def product_info
    @product = @shop.products.where(shopify_id: params[:product_id]).take

    @product_template = if @product.present? && @product.is_bookable? 
      'scripttags/types/from_and_to_form.html'
    else
      ''
    end
    respond_to do |format|
      format.json
    end
  end

  def booking
    respond_to do |format|
      format.js
    end
  end

  def client_calendar
    respond_to do |format|
      format.js
    end
  end

  def bookings
    @bookings = @shop.bookings
    respond_to do |format|
      format.json
    end
  end

  private

    def set_shop
      @shop = Shop.find_by_shopify_domain(params[:shop])
    end

    def add_allow_credentials_headers
      response.headers['Access-Control-Allow-Origin'] = '*'#request.headers['Origin'] || @shop.shopify_domain  
      response.headers['Access-Control-Allow-Credentials'] = 'true'
    end
end
