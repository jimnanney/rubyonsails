Rails.application.routes.draw do
  root to: "static#index"

  # ---------------------------------------------------------------------------
  # Omniauth stuff.
  # ---------------------------------------------------------------------------

  match "/auth/github", :to => "session#github", :via => :get, :as => :auth_github
  match "/auth/github/callback", :to => "session#create", :via => :get, :as => :auth_github_callback
  match "/auth/logout", :to => "session#delete", :via => [:get, :delete], :as => :auth_logout

  # ---------------------------------------------------------------------------
  # Account stuff.
  # ---------------------------------------------------------------------------

  match "/account", :to => "account#update", :via => [:patch, :post]
  match "/account", :via => :get, :to => "account#edit"

  # ---------------------------------------------------------------------------
  # Submission stuff.
  # ---------------------------------------------------------------------------

  match "/submission", :via => [:get], :to => "submission#show"
  match "/submission", :via => [:patch, :post], :to => "submission#create"
  match "/submission/edit", :via => :get, :to => "submission#edit"
  match "/submission/new", :via => :get, :to => "submission#new"

  # ---------------------------------------------------------------------------

  namespace :admin do
    match "/users", :via => :get, :to => "users#index"
    match "/users/delete", :via => [:get, :delete], :to => "users#delete"
  end
end
