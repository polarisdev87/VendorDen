class Shop < ActiveRecord::Base

  #--------------------------------------------------------------------
  # Modules Included
  #--------------------------------------------------------------------
  include ShopifyApp::SessionStorage

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :admin_user, class_name: User.name, optional: true

  has_one :setting, dependent: :destroy

  has_many :users, dependent: :destroy
  has_many :vendor_invites, dependent: :destroy
  has_many :vendors
  has_many :time_slots, dependent: :destroy
  has_many :products
  has_many :payouts
  has_many :bookings

  #--------------------------------------------------------------------
  # Callbacks
  #--------------------------------------------------------------------
  before_create :setup_setting

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Shop::PayoutProcessingConcern
  include Shop::BookingProcessingConcern
  include Shop::ReportDataGeneratorConcern

  #--------------------------------------------------------------------
  # Delegations
  #--------------------------------------------------------------------
  delegate :has_payment_info?, to: :setting

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------

  def shopify_session(&block)
    ShopifyAPI::Session.temp(self.shopify_domain, self.shopify_token, &block)
  end

  def name
    @shop_name ||= shopify_session { ShopifyAPI::Shop.current.name }
  end

  def shopify_products
    shopify_session { ShopifyAPI::Product.all.to_a
      .map { |p| ShopifyProduct.new(self, p) } }
  end

  def booked_shopify_products
    shopify_products.select { |p| p.is_booked? }
  end

  def unbooked_shopify_products
    shopify_products.select { |p| not p.is_booked? }
  end

  def find_shopify_product(id)
    shopify_product = shopify_session { ShopifyAPI::Product.find(id) }
    ShopifyProduct.new(self, shopify_product)
  end

  def has_admin_user?
    self.admin_user.present?
  end

  def has_no_admin_user?
    not has_admin_user?
  end

  private

    def setup_setting
      self.setting = build_setting
      self.setting.minimum_commission_per_product = 0
    end
end
