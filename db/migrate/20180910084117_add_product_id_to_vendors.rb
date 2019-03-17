class AddProductIdToVendors < ActiveRecord::Migration[5.2]
  def change
  	add_column :vendors, :product_id, :integer
  end
end
