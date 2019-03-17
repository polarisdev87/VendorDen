class AddPaymentRelatedColumnsToPayouts < ActiveRecord::Migration[5.2]
  def change
    add_column :payouts, :status, :string, default: 'unpaid'
    add_column :payouts, :paid_date, :datetime
    add_column :payouts, :payment_type, :string
    add_column :payouts, :payment_info, :text
    add_column :payouts, :product_id, :integer
  end
end
