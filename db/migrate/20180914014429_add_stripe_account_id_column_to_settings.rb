class AddStripeAccountIdColumnToSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :settings, :stripe_account_id, :string
  end
end
