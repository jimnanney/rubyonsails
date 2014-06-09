class Admin::UsersController < ApplicationController
  before_filter :admin?
  before_filter :id_present?,
    :deleting_self?, {
      :only => :delete
  }

  allow_param :id, {
    :only => :delete
  }

  # ---------------------------------------------------------------------------
  # GET: /account/users
  # ---------------------------------------------------------------------------

  def index
    @accounts = Account.all
  end

  # ---------------------------------------------------------------------------
  # GET,DELETE: /account/users/delete?aid=?
  # ---------------------------------------------------------------------------

  def delete
    if a = Account.find(safe_params[:id]).destroy
      redirect_to :admin_users, {
        :success => "#{a.name} has been successfully deleted."
      }
    else
      # This is only corner cover
      redirect_to :admin_users, {
        :error => "There was an error destroying the account for #{name}"
      }
    end
  end

  private
  def id_present?
    unless safe_params[:id].present?
      redirect_to :admin_users, {
        :error => "Cannot destroy an account without an ID."
      }

      return false
    end
  end

  private
  def deleting_self?
    # Using integer so we can throw that shit.
    if Integer(safe_params[:id]) == session[:id]
      redirect_to :admin_users, {
        :error => "I see what you did there, can't delete yourself."
      }

      return false
    end
  rescue ArgumentError => e
    if e.message =~ /\Ainvalid value for Integer/
      redirect_to :admin_users, {
        :error => "You're an admin, seriously, do you know what id means?"
      }

      return false
    else
      raise e
    end
  end
end
