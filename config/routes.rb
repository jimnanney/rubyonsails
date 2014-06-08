Rails.application.routes.draw do
  root to: "static#index"

  # ---------------------------------------------------------------------------
  # Omniauth stuff.
  # ---------------------------------------------------------------------------

  get "/auth/github", :to => "session#github", :as => :auth_github
  get "/auth/github/callback", :to => "session#create", :as => :auth_github_callback
  get "/auth/logout", :to => "session#delete", :as => :auth_logout

  # ---------------------------------------------------------------------------
  # Account stuff.
  # ---------------------------------------------------------------------------

  match "/account", :to => "account#update", :via => [:patch, :post], :as => :account_update
  match "/account", :via => :get, :to => "account#edit"
end
