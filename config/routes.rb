Rails.application.routes.draw do
  #api
  namespace :api do
    namespace :v1 do
      resources :items
      resources :item_categories
      resources :users
      get "/item_categories/:item_category_id/items/", to: 'items#show_by_category'
      get "/users/:user_id/items/", to: 'items#show_by_user'
    end
  end

  #application
  root 'static_pages#home'
  get '/home', 			    to: 'static_pages#home'
  get '/about', 		    to: 'static_pages#about'
  
  get '/signup', 		    to: 'users#new'
  get '/profile/edit', 	to: 'users#edit'
  get '/profile', 		  to: 'users#show'
  get '/users',         to: 'users#new'
  
  get '/login', 		    to: 'sessions#new'
  post '/login', 		    to: 'sessions#create'
  delete '/logout', 	  to: 'sessions#destroy'

  get '/item/donate',   to: 'items#new'
  get '/items/edit',    to: 'items#edit'

  resources :users
  resources :items

  match '*path', via: :all, to: 'static_pages#not_found'
end