Rails.application.routes.draw do
  devise_for :users
  get "persons/profile"
  root 'posts#index', as: 'home'

  get 'about' => 'pages#about', as: 'about'

  get 'persons/profile', as: 'user_root'


  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

end
