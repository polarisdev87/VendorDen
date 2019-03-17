class AddEmailColumnToVendorInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :vendor_invites, :email, :string, nil: false
  end
end
