class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|

      t.integer  :shop_id

      t.string   :description
      t.string   :start_date
      t.string   :start_time
      t.datetime :start_at
      t.string   :end_date
      t.string   :end_time
      t.datetime :end_at
      t.boolean  :is_all_day

      t.timestamps
    end
  end
end
