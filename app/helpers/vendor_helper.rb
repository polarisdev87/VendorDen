module VendorHelper

  def vendor_sidebar_active_class(section_name)
    if controller_name == 'vendors' and action_name == section_name.to_s
      'active'
    else
      ''
    end
  end
end
