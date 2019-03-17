module HomeHelper

  def shopify_home_tab_active_class(tab_name, options={})
    the_options = options.with_indifferent_access
    css_active_class = the_options[:active] || 'active'
    css_inactive_class = the_options[:inactive] || ''
    css_class_name = case tab_name
    when :dashboard 
      (params[:tab].blank? || params[:tab] == tab_name.to_s) ? css_active_class : css_inactive_class 
    else
      (params[:tab] == tab_name.to_s) ? css_active_class : css_inactive_class 
    end
    css_class_name
  end
end
