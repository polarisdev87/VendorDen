class Shopify::SettingsController < Shopify::BaseController

	def update
		@setting = current_shop.setting
		if @setting.update_attributes(setting_params)
			redirect_to shopify_root_path('tab' => 'settings')
			flash.notice = 'Settings successfully updated'
		end
	end

	private 

	  def setting_params
		  params.require(:setting).permit(
			  :shop_id,
			  :minimum_commission_per_product,
			  :structure_type
		  )
	  end
end
