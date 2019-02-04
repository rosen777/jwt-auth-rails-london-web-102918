Rails.application.routes.draw do
  # localhost:3000/api/v1/login
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      post 'signin', to: 'users#signin'
      get 'validate', to: 'users#validate'
    end
  end
end
