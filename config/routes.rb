Rails.application.routes.draw do
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
