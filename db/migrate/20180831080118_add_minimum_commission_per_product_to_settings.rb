class AddMinimumCommissionPerProductToSettings < ActiveRecord::Migration[5.2]
  def change
  	add_column :settings, :minimum_commission_per_product, :integer
  end
end
