Rails.application.routes.draw do
  root 'static_pages#home'
  get '/home', 			    to: 'static_pages#home'
  get '/about', 		    to: 'static_pages#about'
  
  get '/signup', 		    to: 'users#new'
  get '/profile/edit', 	to: 'users#edit'
  get '/profile', 		  to: 'users#show'
  
  get '/login', 		    to: 'sessions#new'
  post '/login', 		    to: 'sessions#create'
  delete '/logout', 	  to: 'sessions#destroy'

  get '/item/donate',   to: 'items#new'
  get '/item/edit',     to: 'items#edit'
  
  resources :users
  resources :items
end