Rails.application.routes.draw do
  namespace :api do
    namespace :users do
      post '/register', to: 'register#create'
      post '/login', to: 'login#auth'
    end
  end
end
