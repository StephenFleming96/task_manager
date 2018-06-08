Rails.application.routes.draw do

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'
	get '/logout', to: 'sessions#destroy'

	get '/dash', to: 'application#index'

	get '/task/new', to: 'tasks#new'
	get '/task/:id/edit', to: 'tasks#edit'
	get '/task/:id', to: 'tasks#show'
	delete '/task/:id', to: 'tasks#destroy'
	post '/task', to: 'tasks#create'
	patch '/task', to: 'tasks#update'

	get '/user', to: 'users#show'
	get '/user/edit', to: 'users#edit'
	delete '/user/', to: 'users#destroy'
	put '/user', to: 'users#update' 
	post '/user', to: 'users#create'
	post '/register', to: 'users#create'
	get '/register', to: 'users#new'

  	#	map 'https:../welcome/index' to welcome#index
  	get 'welcome/index'

  	# welcome controller, index method
  	root 'welcome#index'

  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
