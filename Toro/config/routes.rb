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
  match 'items/:id/newOffer' => 'items#newOffer', :as => "newOffer_item"
  post "items/:id/createOffer" => "items#createOffer", :as => "createOffer_item"
  match 'items/:id/deleteOffer' => 'items#deleteOffer', :as => "deleteOffer_item"

  match 'categories' => 'categories#index', :as => "categories"
  match 'categories/new' => 'categories#new', :as => "new_category"
  post "categories/create" => "categories#create", :as => "create_category"
  get "/categories/:id/destroy" => "categories#destroy", :as => :delete_category
  get "/categories/:id/edit" => "categories#edit", :as => :edit_category
  post "categories/:id/update" => "categories#update", :as => "update_category"

  match 'banks' => 'banks#index', :as => "banks"
  match 'banks/new' => 'banks#new', :as => "new_bank"
  post "banks/create" => "banks#create", :as => "create_bank"
  get "/banks/:id/destroy" => "banks#destroy", :as => :delete_bank
  get "/banks/:id/edit" => "banks#edit", :as => :edit_bank
  post "banks/:id/update" => "banks#update", :as => "update_bank"

  # prevent access to the pages we are not using from devise
  match 'users/sign_up' => redirect('/404.html')
  match 'users/password/new' => redirect('/404.html')
  match 'users/password/edit' => redirect('/404.html')

  devise_for :users do 
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  root :to => "home#index"
  get "home/index"
  match 'staff/choose_mode' => 'staff#choose_mode', :as => "staff_choose_mode"

  match 'tables' => 'table#index', :as => "tables"
  match "/:table_id/order"=>"table#order", :as => "order"

  post "/tables/:table_id/move"=>"table#move", :as => "move_table"

  match "add_table/:number/:placement" => "table#add_table", :as => :add_table
  match "remove_table/:number/:placement" => "table#remove_table", :as => :remove_table
  match "close_shift" => "table#close_shift", :as => :close_shift
  match "close_day" => "table#close_day", :as => :close_day

  match "summary" => "summary#index", :as => :summary
  match "/filter" => "summary#filter", :as => :filter
  match "/filtered" => "summary#filtered", :as => :filtered
  match "/:date1/:date2/:shift/print" => "summary#print", :as => :summary_print


  match "/:check_id/close_cheque" => "table#close_cheque", :as => "close_cheque"
  match "/:check_id/add_data" => "table#add_data", :as => "add_data"
  match "/:check_id/print" => "table#print", :as => "print"
  match "/:check_id/pay_cash" => "table#pay_cash", :as => "pay_cash"
  match "/:check_id/pay_credit" => "table#pay_credit", :as => "pay_credit"
  match "/:check_id/pay_staff" => "table#pay_staff", :as => "pay_staff"
  match "/:check_id/pay_officer" => "table#pay_officer", :as => "pay_officer"
  post "/:check_id/new_officer" => "officers#new_officer", :as => "new_officer"
  post "/:check_id/pay_officer_exists" => "officers#pay_officer_exists", :as => "pay_officer_exists"
  match "/:check_id/:bank_name/pay_visa" => "table#pay_visa", :as => "pay_visa"
  put "/:check_id/create_check" => "table#create_check", :as => "create_check"
  put "/:item_id/:order_id/:check_id/transfer_item" => "table#transfer_item", :as => "transfer_item"

  match "/:choice/:table_id/new_order"=>"table#new_order", :as => "new_order"
  post "/:table_id/give_order" => "table#give_order", :as => "give_order"

  match "/:check_id/:order_id/:item_id/decrement_quantity" => "table#decrement_quantity", :as => "decrement_quantity"
  match "/:check_id/:order_id/:item_id/move_item" => "table#move_item", :as => "move_item"

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
