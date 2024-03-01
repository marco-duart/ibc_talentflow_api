# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  namespace :api do
    namespace :users do
      post '/', to: 'register#create'
      post '/email', to: 'register#email_availability'
      post '/cpf', to: 'register#cpf_availability'
      post '/confirm/:id', to: 'register#confirm_account'

      post '/login', to: 'login#auth'
      post '/forget-password', to: 'login#forget_password'
      post '/reset-password', to: 'login#reset_password'
    end

    namespace :candidates do
      post '/', to: 'candidates#create'

      get '/documents', to: 'documents#fetch_all'
      get '/document/:id', to: 'documents#fetch_by_id'
      post '/document', to: 'documents#create'
      patch '/document/:id', to: 'documents#update'
      delete '/document/:id', to: 'documents#delete'

      get '/academics', to: 'academic_histories#fetch_all'
      get '/academic/:id', to: 'academic_histories#fetch_by_id'
      post '/academic', to: 'academic_histories#create'
      patch '/academic/:id', to: 'academic_histories#update'
      delete '/academic/:id', to: 'academic_histories#delete'

      get '/employments', to: 'employment_histories#fetch_all'
      get '/employment/:id', to: 'employment_histories#fetch_by_id'
      post '/employment', to: 'employment_histories#create'
      patch '/employment/:id', to: 'employment_histories#update'
      delete '/employment/:id', to: 'employment_histories#delete'

      get '/links', to: 'professional_links#fetch_all'
      get '/link/:id', to: 'professional_links#fetch_by_id'
      post '/link', to: 'professional_links#create'
      patch '/link/:id', to: 'professional_links#update'
      delete '/link/:id', to: 'professional_links#delete'

      post '/skill', to: 'skills#create'
      delete '/skill/:id', to: 'skills#delete'

      post '/knowledge', to: 'knowledges#create'
      delete '/knowledge/:id', to: 'knowledges#delete'

      get '/applications', to: 'application_status#fetch_all'
      get '/application/:id', to: 'application_status#fetch_by_id'
      post '/application', to: 'application_status#create'
      delete '/application/:id', to: 'application_status#delete'

      get '/application-form/:id', to: 'application_forms#fetch_by_id'
      post '/application-form/response', to: 'application_forms#create_response'

      get '/application-exam/:id', to: 'application_exams#fetch_by_id'
      post '/application-exam/response', to: 'application_exams#create_response'
    end

    namespace :admins do
      post '/ban', to: 'users#ban_user'

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

      get '/hirings', to: 'hirings#fetch_all'
      get '/hiring/:id', to: 'hirings#fetch_by_id'
      post '/hiring', to: 'hirings#create'
      post '/hiring/priority/:id', to: 'hirings#priority_vacancy'
      patch '/hiring/:id', to: 'hirings#update'
      delete '/hiring/:id', to: 'hirings#delete'

      get '/forms', to: 'forms#fetch_all'
      get '/form/:id', to: 'forms#fetch_by_id'
      post '/form', to: 'forms#create'
      patch '/form/:id', to: 'forms#update'
      delete '/form/:id', to: 'forms#delete'
      post '/form/:id/field', to: 'forms#create_field'

      get '/exams', to: 'exams#fetch_all'
      get '/exam/:id', to: 'exams#fetch_by_id'
      post '/exam', to: 'exams#create'
      post '/exam/:id/question', to: 'exams#create_question'

      get '/skill', to: 'skills#fetch_all'
      post '/skill', to: 'skills#create'
      delete '/skill/:id', to: 'skills#delete'

      get '/knowledge', to: 'knowledges#fetch_all'
      post '/knowledge', to: 'knowledges#create'
      delete '/knowledge/:id', to: 'knowledges#delete'

      get '/profile', to: 'profiles#fetch_all'
      post '/profile', to: 'profiles#create'
      delete '/profile/:id', to: 'profiles#delete'
      post '/candidate-profile', to: 'profiles#create_candidate_profile'
      delete '/candidate-profile', to: 'profiles#delete_candidate_profile'

      get '/candidate', to: 'candidates#fetch_by_id'

      get '/applications', to: 'application_status#fetch_all'
      get '/application/:id', to: 'application_status#fetch_by_id'
      patch '/application', to: 'application_status#update'
    end

    namespace :ti do
      post '/admins', to: 'admins#create'
    end
  end
end
