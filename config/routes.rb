Rails.application.routes.draw do

  get "sign_up" => "users#new", :as => "sign_up"
  resources :users

  root :to => "articles#index"
  resources :articles do
    collection{ post :import}
  end
  resources :comments

  resources :sessions

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
