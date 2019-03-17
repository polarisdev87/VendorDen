class CreateProductBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :product_bookings do |t|

      t.references :product
      t.references :timeslot

      t.timestamps
    end
  end
end
