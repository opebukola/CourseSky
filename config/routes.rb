Coursesky::Application.routes.draw do
  get "enrollments/create"

  get "enrollments/destroy"

  mount Ckeditor::Engine => '/ckeditor'

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
  		get :manage, :students
  		put :publish, :feature
  	end
  end
  resources :questions do
    member do
      post :check_correct
    end
  end
  resources :categories
  resources :enrollments, only: [:create, :destroy]
  resources :course_reviews


  root to: 'static_pages#home'

  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact' 
  match '/teach', to: 'static_pages#teach'
end
