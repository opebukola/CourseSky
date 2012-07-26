Coursesky::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show] do
    member do
      get :dashboard
    end
  end
  resources :courses do
    resources :lessons do
      collection {post :sort}
    end
    collection do
      get :admin
    end
  	member do
  		get :manage
  		put :publish, :feature
  	end
  end


  root to: 'static_pages#home'

  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact' 
  match '/teach', to: 'static_pages#teach'
end
