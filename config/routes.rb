Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  devise_for :users, controllers: { sessions: 'users/sessions', confirmations: 'users/confirmations' }

  mount ShopifyApp::Engine, at: '/shopify'

  namespace :shopify do

    resources :vendor_invites do
      member do
        delete :cancel
      end
    end

    resources :vendors do
      member do
        patch :change_status
      end
    end

    resources :products

    resources :time_slots
    resources :bookings

    resources :payouts do
      member do
        patch :manual_payment
        patch :stripe_payment
      end
    end

    resource :setting

    resource :admin_user_setup, only: %i[show create]
    resource :payment_setup, only: %i[show]

    root :to => 'home#index'
  end

  resource :vendor_invite_wizard do
    get   :set_password
    patch :set_password
    get   :complete_info
    post  :complete_info
    get   :payment_info
  end

  resource :vendor do
    get :dashboard
    get :calendar
    get :bookings
    get :products
    get :orders
    get :payouts
    get :settings
  end

  resource :admin do
    get :dashboard
  end

  get "/stripe/connect/vendor_connect/callback", to: 'stripe#vendor_connect_callback', as: 'stripe_vendor_connect_callback'
  get "/stripe/connect/admin_connect/callback", to: 'stripe#admin_connect_callback', as: 'stripe_admin_connect_callback'


  post "/stripe/account/webhook", to: 'stripe#account_webhook', as: 'stripe_account_webhook'
  post "/stripe/connect/webhook", to: 'stripe#connect_webhook', as: 'stripe_connect_webhook'

  get "/shopify/scripttags/booking.js", to: 'scripttags#booking', as: 'scripttags_booking_script'
  get "/shopify/scripttags/products/:product_id/info.json", to: 'scripttags#product_info', as: 'scripttags_product_info'
  get "/shopify/scripttags/client_calendar.js", to: 'scripttags#client_calendar', as: 'scripttags_client_calendar_script'
  get "/shopify/scripttags/bookings.json", to: 'scripttags#bookings', as: 'scripttags_bookings_script'

  resources :time_slots

  resources :products do
    get :new
    get :show
    post :create
    patch :update
  end

  resources :orders do
    
  end

  root :to => 'home#index'
end
