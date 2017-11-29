Rails.application.routes.draw do
  resources :categories do
    resources :projects
    resources :jobs
  end
  
  resources :projects
  resources :jobs

  root "pages#index"

  get "/about" => "pages#about"
  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "logout#logout"

  get "/projects/:id/upvote" => "projects#upvote"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
