class Shopify::AdminUserSetupsController < Shopify::BaseController

  skip_before_action :check_prerequisites!

  def show
    @user = current_shop.users.build({
      email: current_shop.shopify_session { ShopifyAPI::Shop.current.email },
      role: User::ADMIN_ROLE
    }) 
  end

  def create
    @user = current_shop.users.build({
      email: current_shop.shopify_session { ShopifyAPI::Shop.current.email },
      role: User::ADMIN_ROLE,
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation]    
    })
    @user.validate_password!
    @user.skip_confirmation!
    if @user.save
      current_shop.update_column(:admin_user_id, @user.id)
      redirect_to shopify_root_path
    else
      render :show
    end 
  end

  private

    def user_params
      params.require(:user).permit(
        :password,
        :password_confirmation
      )
    end
end
