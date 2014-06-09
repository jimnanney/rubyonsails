module AccountConcerns
  extend ActiveSupport::Concern

  included do
    before_action :setup_account!
  end

  private
  def setup_account!
    @account = Account.find_account_or_give_guest({
      :id => session[:id]
    })

    if @account.guest? && session[:id]
      reset_session
    end
  end

  private
  def admin?
    unless @account && @account.admin?
      raise NotFoundError
    end
  end

  private
  def submitter?
    unless @account.type == :submitter
      redirect_to :root, {
        :error => "This action is for submitters only."
      }
    end
  end

  private
  def reviewer?
    unless @account.type == :reviewer
      redirect_to :root, {
        :error => "This action is for reviewers only."
      }

      return false
    end
  end

  private
  def submitter?
    unless @account.submitter?
      redirect_to :root, {
        :error => "This action is for submitters only."
      }
    end
  end

  private
  def ensure_logged_in!
    if @account.guest?
      redirect_to :root, {
        :error => "I don't think you belong there."
      }

      return false
    end
  end
end
