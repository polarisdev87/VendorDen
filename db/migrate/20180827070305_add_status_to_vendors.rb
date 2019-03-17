class AddStatusToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :status, :string
  end
end
