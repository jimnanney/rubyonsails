module AccountConcerns
  extend ActiveSupport::Concern

  included do
    before_action :_setup_account!
  end

  private
  def _setup_account!
    @account = Account.find_account_or_give_guest({
      :id => session[:id]
    })

    if @account.guest? && session[:id]
      reset_session
    end
  end

  private
  def _admin?
    unless @account && @account.admin?
      raise NotFoundError
    end
  end

  private
  def _submitter?
    unless @account.type == :submitter
      redirect_to :root, {
        :error => "This action is for submitters only."
      }
    end
  end

  private
  def _reviewer?
    unless @account.type == :reviewer
      redirect_to :root, {
        :error => "This action is for reviewers only."
      }

      return false
    end
  end

  private
  def _submitter?
    unless @account.submitter?
      redirect_to :root, {
        :error => "This action is for submitters only."
      }
    end
  end

  private
  def _ensure_logged_in!
    if @account.guest?
      redirect_to :root, {
        :error => "I don't think you belong there."
      }

      return false
    end
  end

  private
  def _ensure_not_logged_in!
    unless @account.guest?
      redirect_to :root, {
        :error => "This action is for unauthenticated users."
      }

      return false
    end
  end
end
