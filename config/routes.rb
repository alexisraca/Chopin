Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root "dashboard#index"

  namespace :admin do
    resources :fast_products
    resources :orders do
      resources :statements
    end

    resources :statements do
      resources :line_items
      resources :payments
    end

    resources :products do
      post "/restore/:id", to: "variants#restore", as: :restore
      resources :variants
    end

    resources :variants do
      resources :promotions
      resources :inventories
    end

    resources :inventories, only: [:destroy, :edit]

    resources :branches
    resources :reports
    resources :users do
      post "/restore", to: "users#restore", as: :restore
    end
    resources :retired_users, only: [:index]
    resources :categories
  end

  namespace :sales do
    resources :orders
    resources :statements do
      resources :line_items
      resources :payments
      put "payment/:id/next", to: "payments#next", as: :payment_next
    end
    resources :variants
  end

  resources :dashboard

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
end
