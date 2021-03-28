Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 registrations: :registrations,
                 sessions: :sessions
             }
  devise_scope :user do
    post 'api/v1/login', to: 'sessions#create'
    post 'api/v1/signup', to: 'registrations#create'
    get 'api/v1/logged_in', to: 'sessions#is_logged_in?'
  end

  root to: "home#index"
  namespace :api do
    namespace :v1 do
      resources :users
      resources :games do
        post 'add_player', on: :member
        delete 'delete_player', on: :member
        get 'status', on: :member
      end
      resources :rounds do
        post 'set_rating', on: :member
      end
      resources :speeches
    end
  end

  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]

  resources :messages, only: [:index, :create]
  mount ActionCable.server => '/cable'
end
