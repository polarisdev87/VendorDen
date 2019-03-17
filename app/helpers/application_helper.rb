module ApplicationHelper
  
  def app_name
    "VendorDen"
  end

  def app_logo
    image_tag('logo.png')
  end

  def page_title
    if is_user_role_vendor? and current_vendor.present?
      current_vendor.business_name
    else
      current_shop.name
    end
  end
end
