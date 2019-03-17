class Shopify::ProductsController < Shopify::BaseController
	
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_shopify_product, only: %i[new create]

  def new
    @product = current_shop.products.build
    @product.set_shopify_product!(@shopify_product)
  end

	def create
		@product = current_shop.products.build(product_params)
    @product.set_shopify_product!(@shopify_product)
		if @product.save
			redirect_to shopify_root_path(tab: 'products')
			flash[:notice] = 'Product was successfully added'
		else
			render :new
		end
	end

  def show
    render :edit
  end

  def edit

  end

  def update
    if @product.update_attributes(product_params)
      redirect_to shopify_root_path(tab: 'products')
      flash[:notice] = 'Product was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy!
    respond_to do |format|
      format.js
    end
  end

	private

    def set_product
      @product = current_shop.products.find(params[:id])
    end
  
  	def product_params
  		params.require(:product).permit(
        :vendor_id,
        :title,
  			:cost_of_goods,
  			:minimum_commission_per_product,
  			:commission_structure_type,
        :is_bookable,
        time_slot_ids: []
  		)
  	end		

    def shopify_product_id
      params[:shopify_product_id]
    end

    def set_shopify_product
      @shopify_product = current_shop.find_shopify_product(shopify_product_id)
    end
end
