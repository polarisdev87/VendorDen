class RemoveAmountPaidOutToDateColumnFromPayouts < ActiveRecord::Migration[5.2]
  def change
    remove_column :payouts, :amount_paid_out_to_date
  end
end
