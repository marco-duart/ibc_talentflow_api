Rails.application.routes.draw do
  namespace :api do

    namespace :users do
      post '/', to: 'register#create'
      post '/email', to: 'register#email_availability'
      post '/cpf', to: 'register#cpf_availability'
      post '/login', to: 'login#auth'
    end

    namespace :candidates do
      post '/', to: 'candidates#create'
    end

    namespace :admins do
      post '/recruiter', to: 'recruiters#create'

      post '/company', to: 'companies#create'
      patch '/company', to: 'companies#update'
      delete '/company', to: 'companies#delete'

      post '/jobs', to: 'jobs#create'
      patch '/jobs', to: 'jobs#update'
      delete '/jobs', to: 'jobs#delete'

      post '/hiring', to: 'hiring#create'
      patch '/hiring', to: 'hiring#update'
      delete '/hiring', to: 'hiring#delete'
    end

    namespace :ti do
      post '/admins', to: 'admins#create'
    end
  end
end
