class ChangeVendorIdsToVendorIdOnProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :vendor_ids
    add_column    :products, :vendor_id, :integer
  end
end
