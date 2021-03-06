PracticeProposalApp::Application.routes.draw do
  require 'resque/server'

  root to: "home#index"
  resources :users,
            constraints: { :protocol => "https" }
  resources :sessions, only: [:new, :create, :destroy]
  resources :proposals
  resources :responses
  resources :incoming_messages, only: :create

  match "/login", to: "sessions#new"
  match "/logout", to: 'sessions#destroy', via: :delete
  match "/api", to: 'api#api_response', via: :post
  match "/_count", to: 'api#pr_count', via: :get

  mount Resque::Server.new, :at => "/resque"
  
  namespace :api, defaults: {format: :json} do
    resources :proposals
    resources :responses
    resources :approvals
  end

  # Catch unroutable paths and send to the routing error handler
  match '*a', :to => 'errors#routing_error'

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
