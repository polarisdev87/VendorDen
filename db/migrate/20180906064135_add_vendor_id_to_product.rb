class AddVendorIdToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :vendor_id, :integer
  end
end
