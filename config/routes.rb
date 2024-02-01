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

      get '/companies', to: 'companies#fetch_all'
      get '/company/:id', to: 'companies#fetch_by_id'
      post '/company', to: 'companies#create'
      patch '/company/:id', to: 'companies#update'
      delete '/company/:id', to: 'companies#delete'

      get '/jobs', to: 'jobs#fetch_all'
      get '/job/:id', to: 'jobs#fetch_by_id'
      post '/job', to: 'jobs#create'
      patch '/job/:id', to: 'jobs#update'
      delete '/job/:id', to: 'jobs#delete'

      get '/hirings', to: 'hiring#fetch_all'
      get '/hiring/:id', to: 'hiring#fetch_by_id'
      post '/hiring', to: 'hiring#create'
      patch '/hiring/:id', to: 'hiring#update'
      delete '/hiring/:id', to: 'hiring#delete'
    end

    namespace :ti do
      post '/admins', to: 'admins#create'
    end
  end
end
