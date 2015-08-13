Arcrecode::Application.routes.draw do

  resources :packing_types

  resources :product_types

  get "admin/list"
  get "admin/edit"
  get "admin/new"
  get "admin/create"
  get "controllername/new"
  get "controllername/create"
  get "upload/select"
  get "upload/successful"
  get "print/select", as: 'print_select'
  get "print/sheet", as: 'print_sheet'
  get "index/index"
  post 'print/sheet', as: 'print_sheet_p'
  get "print/selectSamples", as: 'print_select_sample'
  post 'print/sheetSample', as: 'print_sheet_sample'
  post 'admin/new', as: 'new_user'
  get 'admin/list', as: 'users_list'
  get 'admin/edit/:id', to: 'admin#edit', as: 'edit_user'
  post 'admin/delete_user', as: 'delete_user'
  post 'products/index', as: 'filterProducts'
  get 'products/index'


  devise_for :users
  resources :products

  resources :admin do
    post :create_user, on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root :to => 'index#index'

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
