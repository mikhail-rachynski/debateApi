Rails.application.routes.draw do
  devise_for :users,
  controllers: {
      registrations: :registrations,
      sessions: :sessions
  }
  root to: "home#index"
  namespace :api do
    namespace :v1 do
      resources :users
      resources :games do
        post 'add_player', on: :member
        post 'delete_player', on: :member
        get 'status', on: :member
      end
    end
  end
end
