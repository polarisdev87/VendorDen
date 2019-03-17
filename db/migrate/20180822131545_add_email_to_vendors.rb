class AddEmailToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :email, :string
  end
end
