Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :user, only: :none do
    collection do
      post :create
    end
  end
end
