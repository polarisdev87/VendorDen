class Booking < ApplicationRecord

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop
  belongs_to :product
  belongs_to :vendor

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :shopify_order_id, presence: true
  validates :shopify_customer_name, presence: true

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Concerns::CalendarableModelConcern
  include Booking::ShopifyConcern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def description
    %{
Order No: #{shopify_order.order_number}
#{shopify_customer_name}      
    }
  end

end
