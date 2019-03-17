class Setting < ApplicationRecord
  #--------------------------------------------------------------------
  # Constants
  #--------------------------------------------------------------------
  DEFAULT_CLIENT_CALENDAR_SHOP_PATH = '/pages/booking-calendar'
  DEFAULT_CLIENT_CALENDAR_HTML_ID = 'launchpeer-booking-calendar'

  #--------------------------------------------------------------------
  # Associations
  #--------------------------------------------------------------------
  belongs_to :shop

  #--------------------------------------------------------------------
  # Validations
  #--------------------------------------------------------------------
  validates :minimum_commission_per_product, presence: true

  #--------------------------------------------------------------------
  # Concerns
  #--------------------------------------------------------------------
  include Concerns::StripeConcern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def client_calendar_shop_path_value
    self.client_calendar_shop_path || DEFAULT_CLIENT_CALENDAR_SHOP_PATH
  end

  def client_calendar_html_id_value
    self.client_calendar_html_id || DEFAULT_CLIENT_CALENDAR_HTML_ID
  end
end
