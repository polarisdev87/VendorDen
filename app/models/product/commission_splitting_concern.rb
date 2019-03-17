module Product::CommissionSplittingConcern
  extend ActiveSupport::Concern

  #--------------------------------------------------------------------
  # Methods
  #--------------------------------------------------------------------
  def calculate_commission_split_for_amount(amount)
    amount_commissions_earned = 0.00  
    amount_to_be_paid_out = 0.00 
    if commission_structure_type_amount?
      amount_to_be_paid_out = amount - minimum_commission_per_product
      amount_commissions_earned = amount - amount_to_be_paid_out
    elsif commission_structure_type_percentage?
      percentage = minimum_commission_per_product / 100.00
      amount_to_be_paid_out = amount - (amount * percentage)
      amount_commissions_earned = amount - amount_to_be_paid_out
    else
      raise "Invalid product commision structure type"
    end
    [amount_commissions_earned, amount_to_be_paid_out]
  end
end
