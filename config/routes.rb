Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :projects
  resources :jobs
  root "pages#index"

  get "/about" => "pages#about"
  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "logout#logout"

  get "/projects/:id/upvote" => "projects#upvote"
end
