Rails.application.routes.draw do
	#resources :users
	resources :tasks

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	get '/register', to: 'users#new'
	post '/register', to: 'users#create'

	get '/dash', to: 'application#index'
	get '/dash/new', to: 'tasks#new'
	get '/dash/tasks/:id/edit', to: 'tasks#edit'

	get '/user', to: 'users#show'
	get '/user/edit', to: 'users#edit'
	delete '/user/delete', to: 'users#delete'
	put '/user', to: 'users#update' 
	post '/user', to: 'users#create'

  	#	map 'https:../welcome/index' to welcome#index
  	get 'welcome/index'

  	# welcome controller, index method
  	root 'welcome#index'

  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
