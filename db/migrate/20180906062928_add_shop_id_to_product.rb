class AddShopIdToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :shop_id, :integer
  end
end
