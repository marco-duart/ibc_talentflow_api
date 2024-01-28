Rails.application.routes.draw do
  namespace :api do
    namespace public do

    end

    namespace :users do
      post '/register', to: 'register#create'
      post '/login', to: 'login#auth'
    end

    namespace :admins do
      post 
    end

    namespace :ti do
      post '/admins/new', to: 'admins#create'
    end

  end
end
