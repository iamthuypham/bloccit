Rails.application.routes.draw do
  resources :comments, only: [:create, :destroy]
  resources :labels, only: [:show]

  resources :questions

  resources :topics do
     resources :posts, except: [:index]
     
  end
  resources :posts, only: [] do
     
  end
  resources :users, only: [:new, :create]
  
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'
  
  root 'welcome#index'
end
