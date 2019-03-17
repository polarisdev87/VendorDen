module Vendor::ReportDataGeneratorConcern
  extend ActiveSupport::Concern

  def generate_payouts_report_data(from=Time.zone.now.beginning_of_month, to=Time.zone.now.end_of_month)
    ActiveRecord::Base.connection.execute(%{
SELECT
  products.title AS product_title
 ,SUM(payouts.amount_to_be_paid_out) as product_paid_out
FROM
  payouts
  INNER JOIN
  products
    ON payouts.product_id = products.id
WHERE
  #{self.class.sanitize_sql_array(["payouts.vendor_id = ?", self.id])}
  AND
  #{self.class.sanitize_sql_array(["payouts.updated_at BETWEEN ? AND ?", from, to])}
GROUP BY
  products.id
ORDER BY
  product_paid_out ASC
LIMIT 5
}).to_a
  end
end
