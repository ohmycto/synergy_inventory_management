Spree::Core::Engine.routes.draw do
  namespace :admin do
    match 'edit_multiple_products' => "products#edit_multiple", :as => :edit_multiple_products_start, :via => :get
    match 'edit_multiple_products/:id' => "products#edit_multiple", :as => :edit_multiple_products, :via => :get
    match 'edit_multiple_products/:id' => "products#update_multiple", :via => :put
    match 'edit_multiple_products/:id' => "products#destroy_multiple", :via => :delete
    match 'switch_product_availability/:id' => "products#switch_availability", :via => :put, :as => :switch_product_availability
  end
end
