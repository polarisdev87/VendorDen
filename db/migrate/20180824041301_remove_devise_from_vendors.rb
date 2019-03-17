class RemoveDeviseFromVendors < ActiveRecord::Migration[5.2]
  def change

    remove_column :vendors, :encrypted_password
    remove_column :vendors, :reset_password_token
    remove_column :vendors, :reset_password_sent_at
    remove_column :vendors, :remember_created_at
  end
end
