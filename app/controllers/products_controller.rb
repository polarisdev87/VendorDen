class ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_product, only: %i[edit update destroy]
  
  def new
    @product = current_shop.products.build
  end

  def create
    @product = current_shop.products.build(product_params)
    if @product.save
      redirect_to '/vendor/products'
      flash[:notice] = 'Product was successfully created'
    else
      render :new
    end
  end

  def show
    render :edit
  end

  def edit
    @product = scope.products.find(params[:id])
  end

  def update
    @product = scope.products.find(params[:id]).first()
    if @product.update_attributes(product_params)
      redirect_to '/vendor/products'
      flash[:notice] = 'Product was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @product = scope.products.find(params[:id])
    if @product.destroy!
      redirect_to '/vendor/products'
      flash[:notice] = 'Product was successfully deleted'
    end
  end

  private

    def scope
      current_vendor || current_shop
    end

    def set_product
      scope.products.find(params[:id])
    end 

    def product_params
      params.require(:product).permit(
        :vendor_id,
        :title,
        :body_html,
        :price,
        :minimum_commission_per_product,
        :commission_structure_type
      )
    end

end
