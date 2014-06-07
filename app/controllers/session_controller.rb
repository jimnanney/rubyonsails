class SessionController < ApplicationController
  def create
    account = Account.github(env["omniauth.auth"])

    if account
      then session[:id] = account.id
      redirect_to :root, {
        :success => "Hello, nice to see you!"
      }
    else
      redirect_to :root, {
        :error => "There was a serious error making your account."
      }
    end
  end

  def delete
    reset_session
    redirect_to :root, {
      :success => "You have been logged out."
    }
  end
end
