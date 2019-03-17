class CreateVendorInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :vendor_invites do |t|
      t.integer :user_id
      t.integer :vendor_id
      t.string  :status, nil: false, default: 'invite_sent'

      t.timestamps
    end
  end
end
