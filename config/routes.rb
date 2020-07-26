Rails.application.routes.draw do
  get 'home/top'
  root 'home#top'
  resources :users
  get '/login' => 'users#login_form'
  post '/login' => 'users#login'
  post '/logout' => 'users#logout'
end
