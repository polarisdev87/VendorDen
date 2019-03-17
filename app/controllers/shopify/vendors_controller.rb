class Shopify::VendorsController < Shopify::BaseController

  def index
    @vendors = current_shop.vendors
  end

  def new
    @vendor = current_shop.vendors.build
  end

  def create
    @vendor = current_shop.vendors.build(vendor_params)
    if @vendor.save
      redirect_to shopify_root_path'tab' => 'vendors'
      flash.notice = 'Vendor was successfuly created'
    else
      render :new
    end
  end

  def change_status
    @vendor = Vendor.find_by_id(params[:id].to_i)
    @vendor.change_status
    redirect_to shopify_root_path'tab' => 'vendors'
  end

  private

    def vendor_params
      params.require(:vendor).permit(
        :business_name,
        :poc_first_name,
        :poc_last_name,
        :phone_number,
        :email,
        :tax_id,
        :address
      )
    end
end
