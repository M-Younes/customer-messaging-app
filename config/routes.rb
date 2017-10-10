Rails.application.routes.draw do
  root 'pages#home'
  get 'users', to: 'pages#users'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :conversations, only: [:create] do 
  	resources :messages, only: [:create]
  	member do
  		post :close
  	end
  end
end
