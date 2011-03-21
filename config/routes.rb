require 'subdomain'
Logit::Application.routes.draw do
	
  	
	resources :firms
	resources :customers	
	resources :employees
	resources :users
	resources :projects
	resources :milestones
	resources :todos
	resources :logs 
  
  resources :public do
    member do
      get "first_user"
      post "create_first_user"
    end
  end    
  resources :user_sessions
  
 
  
  match "/login" => "user_sessions#new"
  match "/logout" => "user_sessions#destroy"
  
  match "/private" => "private#index",  :as => :private
  match "/archive" => "projects#archive",  :as => :archive
  match "projects/update_index/:id" => "projects#update_index",  :as => :update_index
  match "projects/create_index/" => "projects#create_index",  :as => :create_index
  match "/register" => "public#register",  :as => :register
  match "/register/:firm_id/user" => "public#first_user",  :as => :register_user
  match "/statistics" => "private#statistics", :as => :statistics
  match "/firm" => "private#firm", :as => :firm
  match "/validates_uniqe/:subdomain" => "public#validates_uniqe", :as => :validates_uniqe
  
  match "/logs_pr_date/:time" => "private#logs_pr_date", :as => :logs_pr_date
  match "/mark_todo_done/:id" => "private#mark_todo_done", :as => :mark_todo_done
  match "/membership/:id/:project_id" => "private#membership", :as => :membership
  match "/customer_employees/:customer_id/:log_id" => "private#customer_employees", :as => :customer_employees
  match "/customer_employees/:customer_id/" => "private#customer_employees", :as => :customer_employees
  match "/customer_employees/" => "private#customer_employees", :as => :customer_employees
  match "/project_todos/:project_id/:log_id" => "private#project_todos", :as => :project_todos
  match "/project_todos/:project_id" => "private#project_todos", :as => :project_todos
  match "/activate_projects/:id" => "private#activate_projects", :as => :activate_projects
  match "/project_todos/" => "private#project_todos", :as => :project_todos
  match "/get_logs/:customer_id" => "private#get_logs", :as => :get_logs
  match "/get_logs_project/:project_id" => "private#get_logs_project", :as => :get_logs_project
  match "/get_users_project/:project_id" => "private#get_users_project", :as => :get_users_project
  match "/get_logs_user/:user_id" => "private#get_logs_user", :as => :get_logs_user
  match "/get_employees/:customer_id" => "private#get_employees", :as => :get_employees
  match "/add_todo_to_logs" => "private#add_todo_to_logs", :as => :add_todo_to_logs
  match "/destroy_all" => "private#destroy_all", :as => :destroy_all
  
  constraints(Subdomain) do
 		root :to => 'firms#show' 
	end
  
  root :to => "public#index"
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
