Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :games do
        post 'add_player', on: :member
      end
    end
  end
end
