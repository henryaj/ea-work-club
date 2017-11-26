Rails.application.routes.draw do
  resources :jobs
  root "pages#index"

  get "/about" => "pages#about"
  get "/auth/oauth2/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get "/logout" => "logout#logout"
end
