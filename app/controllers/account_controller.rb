class AccountController < ApplicationController
  allow_param({
    :account => [
      :name,
      :email,
      :bio,
    ],
  }, {
    :only => :update
  })

  before_action :_ensure_logged_in!
  skip_before_action :_set_page_title!, :only => :edit
  before_action :_set_page_title!, :only => :edit
  page_title :edit, "Your Account Settings"

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
