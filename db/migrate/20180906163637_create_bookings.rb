class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|

      t.string     :name
      t.string     :description
      t.references :shop
      t.references :time_slot
      t.references :vendor
      t.string     :start_date
      t.string     :start_time
      t.datetime   :start_at
      t.string     :end_date
      t.string     :end_time
      t.datetime   :end_at
      t.boolean    :is_all_day

      t.timestamps
    end
  end
end
