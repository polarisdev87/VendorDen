class CreateBookingsAgain < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :product
      t.references :vendor
      t.references :shop
      t.string     :start_date
      t.string     :start_time
      t.datetime   :start_at
      t.string     :end_date
      t.string     :end_time
      t.datetime   :end_at
      t.string     :shopify_order_id
      t.string     :shopify_customer_name
      t.string     :shopify_order_line_item_id

      t.timestamps
    end
  end
end
