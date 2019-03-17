module AdminHelper

  def admin_sidebar_active_class(section_name)
    if controller_name == 'admins' and action_name == section_name.to_s
      'active'
    else
      ''
    end
  end
end
