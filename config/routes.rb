Rails.application.routes.draw do
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :projects
  resources :jobs

  resources :categories do
    resources :projects
    resources :jobs
  end

  get "/subscription" => "subscriptions#edit"
  get "/unsubscribe" => "subscriptions#destroy"
  post "/subscription" => "subscriptions#create_or_update"
  patch "/subscription" => "subscriptions#create_or_update"

  get "/search" => "pages#search"
  get "/locationsearch" => "pages#location_search"

  root "pages#index"

  get "/about" => "pages#about"
  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "logout#logout"

  get "/projects/:id/upvote" => "projects#upvote"



  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
