class AddShopIdToSettings < ActiveRecord::Migration[5.2]
  def change
  	add_column :settings, :shop_id, :integer
  end
end
