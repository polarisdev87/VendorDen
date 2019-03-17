class AddShopIdColumnToVendorInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :vendor_invites, :shop_id, :integer
  end
end
