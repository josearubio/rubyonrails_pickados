Rails.application.routes.draw do

  get 'bugtracking/new', as: :newbugtracker

  get 'bugtracking/index'

  post 'createbug' => 'bugtracking#create', as: :bugtrackers

  post 'addcomment' => 'bugtracking#addcomment', as: :comments

  get 'tipsters/index', as: :tipster

  get 'ranking/index', as: :ranking

  get 'welcome/index/:sport/:all' => 'welcome#index', as: :pickbysport

  get 'stats/index'

  get 'index' => 'static_pages#index', as: :indexhome

  get 'reports' => 'static_pages#reports', as: :reports

  get 'mostrarexplicacion' => 'picks#mostrarexplicacion', as: :mostrarexplicacion

  get 'mispicks/:id' => 'static_pages#mispicks', as: :mispicks
  get 'mispicks/:id/:sport' => 'static_pages#mispicks', as: :mispicksbysport

  get 'favorites' => 'static_pages#favorites', as: :favorites

  post 'usersetpro' => 'users#setpro', as: :userpro

  post 'reportpick' => 'picks#report', as: :report

  get 'users/:id/sport/:sport' => 'users#show', as: :userpicksbysport
  get 'faq' => 'static_pages#faq'

  get 'contacto' => 'static_pages#contacto'

  get 'password_resets/edit'

  get 'password_resets/new'

  get 'password_resets/edir'

  get 'sessions/new'

  get 'signup' => 'users#new'

  get 'welcome/index'
	
	get 'inicio/index'

  get 'picks/:id/tick/:result' => 'picks#tickar', as: :tick_pick

  get 'picks/:id/fav' => 'picks#fav', as: :fav_pick
  get 'picks/:id/unfav' => 'picks#unfav', as: :unfav_pick

  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
resources :picks
  resources :users do
    member do
    get :following, :followers
  end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
end
