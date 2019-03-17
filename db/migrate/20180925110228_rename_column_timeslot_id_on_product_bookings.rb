class RenameColumnTimeslotIdOnProductBookings < ActiveRecord::Migration[5.2]
  def change
    rename_column :product_bookings, :timeslot_id, :time_slot_id
  end
end
