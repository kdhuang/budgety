Budgety::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  match '/login' => "user#login", :as => :login
  match '/logout' => "user#logout", :as => :logout

  match '/home' => "index#home", :as => :home

  match '/t/new' => "transaction#new", :as => :new_transaction
  match '/t/edit' => "transaction#edit", :as => :edit_transaction
  match '/t/show' => "transaction#show", :as => :show_transaction
  match '/t/delete' => "transaction#delete", :as => :delete_transaction
  match '/t/show_month' => "transaction#show_month", :as => :show_month_transaction

  match '/b/new' => "budget_history#new", :as => :new_budget
  match '/b/update' => "budget_history#update", :as => :update_budget
  
  # deprecated - allows manual recalculation of budget on home page. replaced by auto recalculation upon each page load
  #match '/b/reset' => "budget_history#reset", :as => :reset_budget
  
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
  # match ':controller(/:action(/:id(.:format)))'

  root :to => 'index#index'
end
