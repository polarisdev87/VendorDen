class AddStripeAccountIdColumnToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :stripe_account_id, :string
  end
end
