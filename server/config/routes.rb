Rails.application.routes.draw do
  # localhost:3000/api/v1/login
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      resources :events, only: [:index, :show, :create, :destroy]
      post 'signin', to: 'users#signin'
      get 'validate', to: 'users#validate'
      get 'joined', to: 'users#get_events'
      post 'joinevent', to: 'events#joinevent'
      delete 'cancelevent', to: 'events#cancelevent'
      delete 'deleteevent',
      to: 'events#deleteevent'
    end
  end
end
