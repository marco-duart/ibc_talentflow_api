Rails.application.routes.draw do
  namespace :api do

    namespace :users do
      post '/register', to: 'register#create'
      post '/email', to: 'register#email_availability'
      post '/cpf', to: 'register#cpf_availability'
      post '/login', to: 'login#auth'
    end

    namespace :candidates do
      post '/new', to: 'candidates#create'
    end

    # namespace :admins do
    #   post 
    # end

    namespace :ti do
      post '/admins/new', to: 'admins#create'
    end
  end
end
