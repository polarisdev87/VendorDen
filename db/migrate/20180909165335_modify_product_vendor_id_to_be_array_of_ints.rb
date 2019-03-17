class ModifyProductVendorIdToBeArrayOfInts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :products, :vendor_id
  	add_column :products, :vendor_ids, :integer, array: true, default: '{}' 
  end
end
