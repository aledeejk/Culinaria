Rails.application.routes.draw do
  devise_for :users
  get "persons/profile"
  root "posts#index", as: "home"

  get "about" => "pages#about", as: "about"

  get "persons/profile", as: "user_root"


  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end

  get "plan" => "pages#plan", as: "plan"
  resources :posts
  get "/create_plan", to: "posts#create_plan", as: :create_plan
end
