class AddDefaultValueToVendorStatus < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :vendors, :status, "Active"
  end
end
