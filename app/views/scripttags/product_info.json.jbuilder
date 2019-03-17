if @product.present?
  json.success true
  if @product_template.present?
    json.form_template render(partial: @product_template, locals: {product: @product})
  else
    json.form_template ''
  end
else
  json.success false
end
