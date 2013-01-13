Coursesky::Application.routes.draw do
  get "enrollments/create"

  get "enrollments/destroy"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}


  resources :users, only: [:show, :destroy, :index] do
    member do
      get :dashboard
      get :college
    end
  end

  resources :courses do
    collection do
      get :admin
    end
    member do
      get :lessons, :manage, :students, :progress, :practice
      put :publish, :feature
    end
  end

  resources :lessons do 
    collection do
      post :sort
    end
    member do
      get :finish
    end
  end

  resources :units do
    collection {post :sort}
  end
  resources :lesson_activities do
    collection {post :sort }
  end

  resources :concepts

  resources :questions do
    member do
      post :check
    end
  end

  resources :quizzes do
    member do
      get :finish
    end
  end
  resources :attempts


  resources :enrollments, only: [:create, :destroy]
  resources :course_reviews
  resources :comments, only: [:new, :create, :destroy]
  resources :skills



  match '/about', to: 'pages#about'
  match '/admin', to: 'pages#admin'
  match '/careers', to: 'pages#careers'
  match '/terms', to: 'pages#terms'
  match '/parents', to: 'pages#parents'
  match '/pricing', to: 'pages#pricing'
  root to: 'pages#home'
end
