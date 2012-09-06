Coursesky::Application.routes.draw do
  get "enrollments/create"

  get "enrollments/destroy"

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  resources :users, only: [:show, :destroy, :index] do
    member do
      get :dashboard
    end
  end
  resources :courses do
    resources :lessons do
      collection do
        post :sort
      end
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
      post :check
    end
  end
  resources :question_attempts, only: [:destroy]
  resources :categories
  resources :enrollments, only: [:create, :destroy]
  resources :course_reviews
  resources :comments, only: [:new, :create, :destroy]
  resources :lesson_progressions, only: [] do
    member do
      put :complete
    end
  end



  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact' 
  match '/teach', to: 'static_pages#teach'
  match '/admin', to: 'static_pages#admin'
  root to: 'static_pages#home'
end
