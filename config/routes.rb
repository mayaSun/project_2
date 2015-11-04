Rails.application.routes.draw do
  root to: 'pages#home'
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'pages#home'
  get '/search', to: 'pages#search'
  get '/about_us', to: 'pages#about_us'
  get '/delivery_information', to: 'pages#delivery_information'
  get 'terms_and_conditions', to: 'pages#terms_and_conditions'
  get '/seed_bank', to: 'pages#seed_bank'
  get '/tincture', to: 'pages#tincture'
  get '/hydrosol', to: 'pages#hydrosol'
  get '/clinics', to: 'pages#clinics'
  get '/active_museum', to: 'active_museum#active_museum'
  get '/plots', to: 'active_museum#plots'
  get '/plant_breeding', to: 'active_museum#plant_breeding'
  get '/cutting', to: 'active_museum#cutting'
  get '/plants_hospital', to: 'active_museum#plants_hospital'

  get '/contact_us', to: 'contact_us#new'
  post '/contact_us', to: 'contact_us#create'

  resources :products , only: [:show, :index] 
  resources :jewelries , only: [:show, :index] 
  resources :jewelry_crystals , only: [:show]
  resources :essential_oils , only: [:show, :index]
  resources :crystals , only: [:show, :index]
  resources :medicinal_herbs , only: [:show, :index]
  resources :medical_activities , only: [:show, :index] 
  resources :active_ingredients , only: [:show, :index] 
  resources :categories, only: [:show]
  resources :recipes, only: [:index]

  namespace :admin do
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :jewelries, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :essential_oils, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :crystals, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :medicinal_herbs, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :medical_activities, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :active_ingredients, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :recipes, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :categories
    resources :orders, only: [:index, :edit, :update]
    resources :users, only: [:index, :update] do
      member do
        get '/orders', to: 'users#orders'
      end
    end
    get '/stock', to: 'products#stock'
    resources :products do
      member do
        patch '/stock', to: 'products#update_stock'
      end
    end
  end

  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  resources :users, only: [:edit, :update] do
    member do
      get '/reset_password', to: 'users#edit_password'
    end
  end  
  get '/my_account', to: 'users#my_account'
  get '/my_orders', to: 'users#my_orders'


  get '/login', to: 'sessions#new'  
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/shopping_cart', to: 'shopping_cart_items#index'
  get '/wishlist', to: 'wishlist_items#index'

  resources :shopping_cart_items ,only: [:create, :update, :destroy]
  resources :wishlist_items ,only: [:create, :destroy]

  get '/checkout', to: 'orders#new'
  post '/checkout', to: 'orders#create' 
  
  resources :orders, only: [:show] do
    collection do
      get '/terms_and_conditions', to: 'orders#terms_and_conditions'
    end
  end 

  resources :addresses, only: [:index, :new, :create, :edit, :update, :destroy]

  get '/thank_you', to: 'pages#thank_you'

  get '/register_to_get_2_plants', to: 'free_plants_orders#new'
  post '/register_to_get_2_plants', to: 'free_plants_orders#create'

  get '/subregion_options' => 'addresses#subregion_options'

  post "/orders/:slug" => "orders#payment_show"
  post "/paypal_hook" => "orders#paypal_hook"

  get '/password_reset', to: "password_resets#new"
  post '/password_reset', to: "password_resets#create"
  get '/confirm_password_reset', to: "password_resets#confirm"
  get '/password_reset/invalid_token', to: "password_resets#invalid_token", as: :invalid_token
  get '/password_reset/:token', to: "password_resets#edit", as: :reset_password
  patch '/password_reset', to: "password_resets#update", as: :update_password
  get '/invalid_token', to: "password_reset#invalid_token"
  get 'sitemap.xml', :to => 'sitemap#index', :defaults => { :format => 'xml' }

end
