Calendar::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: "registrations", sessions: "sessions"}

  devise_scope :user do
    match 'verify_email', to: 'omniauth_callbacks#verify_email'
    match 'email_already_exist', to: 'omniauth_callbacks#email_already_exist'
    match 'fill_email', to: 'omniauth_callbacks#fill_email'
    match 'social_profile_already_connected', to: 'omniauth_callbacks#social_profile_already_connected'
  end

  resources :calendars do
    get :make_paid, on: :member
    get :list, on: :collection
    resources :calendar_colors
    resources :price_periods
  end
  match '/:id' => 'calendars#show', as: :public_calendar, constraints: { id: /\d+/ }
  match 'list/:user_id' => 'calendars#public_list', as: :public_list, constraints: { user_id: /\d+/ }
  resources :periods
  resources :pages
  match '/contact_us' => 'home#contact_us', as: :contact_us

  resources :payment_notifications, only: :create do
    collection do
      post :paypal_return
      get :paypal_cancel
    end
  end

  resources :social_profiles, only: :destroy

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
