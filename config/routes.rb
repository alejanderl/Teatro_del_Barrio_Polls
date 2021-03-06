TeatroDelBarrio::Application.routes.draw do

  




  get "landing/index"
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

    


    root :to => 'polls#index'


    devise_for :users
    get "users/index"

    resources :taxonomies
    resources :terms
    resources :memberships
     match "massive_updated/",:to =>  "memberships#massive_update" , :via => [:post], :as => :massive_update_memberships

    resources :polls 
    match "vote/:question_id/:my_vote",:to =>  "votes#create" , :via => [:get], :as => :voting
    match "unvote/:question_id"       ,:to =>  "votes#destroy", :via => [:get], :as => :destroy_vote

    resources :admins
      match "admins/change_superadmin/:user_id",:to =>  "admins#change_superadmin" , :via => [:get], :as => :change_superadmin
    

  end
  
  
  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }, via: [:get, :post]
  match ''     , to: redirect("/#{I18n.default_locale}"), via: [:get, :post]

end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  

