Toro::Application.routes.draw do

  # routes to crud users, must be before devise routes
  match 'users/index' => 'users#index', :as => "users"
  match 'users/new' => 'users#new', :as => "new_user"
  post "users/create" => "users#create", :as => "create_user"
  get "/users/:id/destroy" => "users#destroy", :as => :delete_user
  get "/users/:id/edit" => "users#edit", :as => :edit_user
  post "users/:id/update" => "users#update", :as => "update_user"

  match 'items' => 'items#index', :as => "items"
  match 'items/new' => 'items#new', :as => "new_item"
  post "items/create" => "items#create", :as => "create_item"
  get "/items/:id/destroy" => "items#destroy", :as => :delete_item
  get "/items/:id/edit" => "items#edit", :as => :edit_item
  post "items/:id/update" => "items#update", :as => "update_item"

  match 'categories' => 'categories#index', :as => "categories"
  match 'categories/new' => 'categories#new', :as => "new_category"
  post "categories/create" => "categories#create", :as => "create_category"
  get "/categories/:id/destroy" => "categories#destroy", :as => :delete_category

  # prevent access to the pages we are not using from devise
  match 'users/sign_up' => redirect('/404.html')
  match 'users/password/new' => redirect('/404.html')
  match 'users/password/edit' => redirect('/404.html')
  match 'users/edit' => redirect('/404.html')

  devise_for :users do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  root :to => "home#index"
  get "home/index"
  match 'staff/choose_mode' => 'staff#choose_mode', :as => "staff_choose_mode"

  match 'tables' => 'table#index', :as => "tables"
  match "add_table/:number/:placement" => "table#add_table", :as => :add_table
  match "remove_table/:number/:placement" => "table#remove_table", :as => :remove_table

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
