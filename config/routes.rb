Rails.application.routes.draw do
  devise_for :users, skip: [:registrations, :sessions]

  get '/users', to: 'users#index'

  as :user do
    post '/users/sign_up', to: 'auth/registrations#create'
    post '/users/sign_in', to: 'auth/sessions#create'
    delete '/users/sign_out', to: 'auth/sessions#destroy'
  end

end
