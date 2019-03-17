module Shop::ReportDataGeneratorConcern
  extend ActiveSupport::Concern

  def generate_product_sales_report_data(from=Time.zone.now.beginning_of_month, to=Time.zone.now.end_of_month)
    ActiveRecord::Base.connection.execute(%{
SELECT
  products.title AS product_title
 ,SUM(payouts.amount_sold) as product_amount_sold
FROM
  payouts
  INNER JOIN
  products
    ON payouts.product_id = products.id
WHERE
  #{self.class.sanitize_sql_array(["payouts.shop_id = ?", self.id])}
  AND
  #{self.class.sanitize_sql_array(["payouts.updated_at BETWEEN ? AND ?", from, to])}
GROUP BY
  products.id
ORDER BY
  product_amount_sold ASC
LIMIT 5
}).to_a
  end

  def generate_product_commissions_earned_report_data(from=Time.zone.now.beginning_of_month, to=Time.zone.now.end_of_month)
    ActiveRecord::Base.connection.execute(%{
SELECT
  products.title AS product_title
 ,SUM(payouts.amount_commissions_earned) as product_amount_commissions_earned
FROM
  payouts
  INNER JOIN
  products
    ON payouts.product_id = products.id
WHERE
  #{self.class.sanitize_sql_array(["payouts.shop_id = ?", self.id])}
  AND
  #{self.class.sanitize_sql_array(["payouts.updated_at BETWEEN ? AND ?", from, to])}
GROUP BY
  products.id
ORDER BY
  product_amount_commissions_earned ASC
LIMIT 5
}).to_a
  end
end
