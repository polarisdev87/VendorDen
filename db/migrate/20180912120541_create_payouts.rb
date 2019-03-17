class CreatePayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :payouts do |t|

      t.timestamps
    end
  end
end
