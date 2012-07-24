Coursesky::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  resources :courses do
  	member do
  		get :manage
  		put :publish
  	end
  end

  root to: 'static_pages#home'

  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact' 
  match '/teach', to: 'static_pages#teach'
end
