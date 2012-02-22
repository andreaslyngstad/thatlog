require 'subdomain'
Logit::Application.routes.draw do
  resources :users
    resources :firms
    resources :public do
      member do
        get "first_user"
        post "create_first_user"
     end
  end    
  
  
  
  devise_for :users

  devise_for :users, :path_names => { :sign_up => "register" }, :controllers => {:registrations => "users"} do
    	get "sign_in", :to => "devise/sessions#new"
    	get "sign_out", :to => "devise/sessions#destroy"
    	get "register", :to => "public#register"
    	get "/register/:firm_id/user" => "public#first_user",  :as => :register_user
    	post "/register/:firm_id/user" => "public#create",  :as => :create_first_user
    	get "/validates_uniqe/:subdomain" => "public#validates_uniqe", :as => :validates_uniqe
      get "/", :to => "public#index"
  	end
  resources :users, :only => [:index, :show, :create, :update, :destroy] do
    member do
     get :valid
    end
  end

  constraints(Subdomain) do
 	root :to	=> "private#statistics"
	match "/statistics" => "private#statistics", :as => :statistics
	match "/reports" => 'private#reports', :as => :reports
	match "/timesheets/:user_id" => 'private#timesheets', :as => :timesheets
	match "/timesheet_logs_day/:user_id/:date" => 'private#timesheet_logs_day', :as => :timesheet_logs_day
	match "/add_log_timesheet" => 'private#add_log_timesheet', :as => :add_log_timesheet
	match "/report_for" => 'private#report_for', :as => :reports_for
	match "/account" => "private#account",  :as => :account
	match "/home_user" => "private#home_user",  :as => :home_user
	match "/firm_update" => "private#firm_update",  :as => :firm_update
	match "/firm_edit" => "private#firm_edit",  :as => :firm_edit
	match "/upgrade" => "private#upgrade",  :as => :upgrade
	match "logs/start_tracking" => "logs#start_tracking",  :as => :start_tracking
	match "logs/stop_tracking/:id" => "logs#stop_tracking",  :as => :stop_tracking
	match "/archive" => "projects#archive",  :as => :archive
	match "projects/update_index/:id" => "projects#update_index",  :as => :update_index
	match "projects/create_index/" => "projects#create_index",  :as => :create_index
	match "/logs_pr_date/:time/:url" => "private#logs_pr_date", :as => :logs_pr_date
  match "/logs_pr_date/:time/:url/:id" => "private#logs_pr_date", :as => :logs_pr_date
  match "/log_range/" => "private#log_range", :as => :log_range  
  match "/mark_todo_done/:id" => "private#mark_todo_done", :as => :mark_todo_done
  match "/membership/:id/:project_id" => "private#membership", :as => :membership
  
  match "/customer_employees/:customer_id/:log_id" => "logs#customer_employees", :as => :customer_employees
  match "/customer_employees/:customer_id/" => "logs#customer_employees", :as => :customer_employees
  
  match "/customer_select_tracking/:customer_id/:log_id" => "logs#customer_select_tracking", :as => :customer_select_tracking
  match "/customer_select_tracking/:customer_id/" => "logs#customer_select_tracking", :as => :customer_select_tracking
  
  match "/employee_select_tracking/:employee_id/:log_id" => "logs#employee_select_tracking", :as => :employee_select_tracking
  match "/employee_select_tracking/:employee_id/" => "logs#employee_select_tracking", :as => :employee_select_tracking
  match "/customer_employees/" => "logs#customer_employees", :as => :customer_employees
  
  match "/project_todos/:project_id/:log_id" => "logs#project_todos", :as => :project_todos
  match "/project_todos/:project_id" => "logs#project_todos", :as => :project_todos 
  match "/project_select_tracking/:project_id/:log_id" => "logs#project_select_tracking", :as => :project_select_tracking
  match "/project_select_tracking/:project_id" => "logs#project_select_tracking", :as => :project_select_tracking 
  match "/todo_select_tracking/:todo_id/:log_id" => "logs#todo_select_tracking", :as => :todo_select_tracking
  match "/todo_select_tracking/:todo_id" => "logs#todo_select_tracking", :as => :todo_select_tracking
  match "/project_todos/" => "logs#project_todos", :as => :project_todos
  match "/todo_select/:todo_id/:log_id" => "logs#todo_select", :as => :todo_select
  match "/todo_select/:todo_id" => "logs#todo_select", :as => :todo_select  
  match "/activate_projects/:id" => "private#activate_projects", :as => :activate_projects

  match "/get_logs/:customer_id" => "private#get_logs", :as => :get_logs
  match "/get_logs_project/:project_id" => "private#get_logs_project", :as => :get_logs_project
  match "/get_users_project/:project_id" => "private#get_users_project", :as => :get_users_project
  match "/get_logs_user/:user_id" => "private#get_logs_user", :as => :get_logs_user
  match "/get_employees/:customer_id" => "private#get_employees", :as => :get_employees
  match "/add_todo_to_logs" => "private#add_todo_to_logs", :as => :add_todo_to_logs
  match "/destroy_all" => "private#destroy_all", :as => :destroy_all

	resources :customers	
	resources :employees
	resources :projects
	resources :milestones
	resources :todos
	resources :logs 
  
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
