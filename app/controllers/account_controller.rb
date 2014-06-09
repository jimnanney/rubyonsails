class AccountController < ApplicationController
  page_title :edit, "Your Account Settings"
  before_action :ensure_logged_in!
  allow_param({
    :account => [
      :name,
      :email,
      :bio,
    ],
  }, {
    :only => :update
  })


  # ---------------------------------------------------------------------------
  # PATCH, POST: /account
  # ---------------------------------------------------------------------------

  def update
    if @account.update(safe_params[:account])
      redirect_to :account, {
        :success => "Your settings have been updated."
      }
    else
      redirect_to :account, {
        :error => @account.errors.full_messages.join(", ")
      }
    end
  end
end
