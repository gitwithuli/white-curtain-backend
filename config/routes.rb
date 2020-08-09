Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # devise_for :users, controllers: { sessions: 'sessions', registrations: 'api/v1/registrations' }
      post 'login' => 'user_token#create'
      resources :users, only: [:create]
      resources :movies, only: [ :index, :show ]do
        post 'follow' => 'movies#follow'
        delete 'unfollow' => 'movies#unfollow'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

