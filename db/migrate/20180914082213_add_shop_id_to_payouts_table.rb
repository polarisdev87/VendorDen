class AddShopIdToPayoutsTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :payouts, :shop_id, :integer
  end
end
