Cove::Application.routes.draw do
  resources :videos
  
  match 'videos/:video_id/tag', :to => 'videos#tag'

  resources :tags

  resources :jobs

  resources :trainings

  match 'jobs/:id/work' => 'jobs#work'

  resource :logging

  namespace :admin do
    get '/' => "search#index", :as => "admin_root"
    get '/search' => "search#show", :as => "search"
  end

  devise_for :users

  root :to => "home#index"

  resources :videos

  match 'certifications/:id/take_test', :to => 'certifications#take_test', :as => 'take_test'

  match 'certification_tests/:id', :to => 'certification_tests#show', :as => 'show_test'
  match 'certification_tests/:id/test_results', :to => 'certification_tests#test_results', :as => 'test_results'
  match 'certification_tests/:id/submit_test', :to => 'certification_tests#submit_test', :as => 'submit_test'

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
