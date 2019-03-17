class AddAcceptedAtColumnToVendorInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :vendor_invites, :accepted_at, :datetime
  end
end
