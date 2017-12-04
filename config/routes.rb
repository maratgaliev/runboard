Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  devise_for :users, skip: [:registrations, :sessions]

  resources :users, only: [:index, :show]

  as :user do
    post '/users/sign_up', to: 'auth/registrations#create'
    post '/users/sign_in', to: 'auth/sessions#create'
    delete '/users/sign_out', to: 'auth/sessions#destroy'
  end

  post '/graphql', to: 'graphql#query'
  
end

