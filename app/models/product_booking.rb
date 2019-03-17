class ProductBooking < ApplicationRecord

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :product
  belongs_to :time_slot
end
