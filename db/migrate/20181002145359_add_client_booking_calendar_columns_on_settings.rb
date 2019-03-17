class AddClientBookingCalendarColumnsOnSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :client_calendar_shop_path, :string
    add_column :settings, :client_calendar_html_id, :string
  end
end
