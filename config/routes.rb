Rails.application.routes.draw do

  root to: 'products#index'

  # Define the route for the about page as '/about'
  get 'about', to: 'about#index'

  # Routes for products, allowing only index and show actions
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  # Routes for the cart, allowing only the show action and adding custom actions for adding/removing items
  resource :cart, only: [:show] do
    # Custom routes for adding and removing items from the cart
    post   :add_item  # Adds an item to the cart
    post   :remove_item # Removes an item from the cart
  end

  # Routes for orders, allowing only create and show actions
  resources :orders, only: [:create, :show]

  namespace :admin do
     # Set the root route for the admin section to the 'show' action of the 'dashboard' controller
    root to: 'dashboard#show'
    # Admin routes for managing products, excluding edit, update, and show actions
    resources :products, except: [:edit, :update, :show]
    # This means the admin can create, index, and destroy products, but cannot edit, update, or view a single product
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
end
