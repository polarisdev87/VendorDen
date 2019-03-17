class AddShopIdColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :shop_id, :integer
  end
end
