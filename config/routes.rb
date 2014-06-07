Rails.application.routes.draw do
  get "/auth/github", :to => "session#github", :as => :auth_github
  get "/auth/github/callback", :to => "session#create", :as => :auth_github_callback
  get "/auth/logout", :to => "session#delete", :as => :auth_logout
  root to: "static#index"
end
