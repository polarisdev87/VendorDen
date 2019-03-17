class AddAttributesToPayout < ActiveRecord::Migration[5.2]
  def change
  	add_column :payouts, :vendor_id, :integer
  	add_column :payouts, :amount_sold, :float
  	add_column :payouts, :amount_commissions_earned, :float
  	add_column :payouts, :amount_to_be_paid_out, :float
  	add_column :payouts, :amount_paid_out_to_date, :float
  end
end
