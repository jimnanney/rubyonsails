class SubmissionController < ApplicationController
  before_filter :_submitter?

  allow_param({
    :submission => [
      :title,
      :text
    ],
  }, {
    :only => :create
  })

  def show
    @submission = @account.submissions.where({
      :current => true
    })

    case true
    when @submission.blank?   then raise UnauthorizedError
    when @submission.size > 1 then raise ServerError
    else
      @submission = @submission.first
      @title      = @submission.title
    end
  end

  alias_method :edit, :show

  def create
    if @account.submissions.create(safe_params[:submission])
      then redirect_to :submission
      else redirect_to :back, {
        :error => "There was an error with your submission."
      }
    end
  end

  def new
    if @account.submissions.any?
      raise UnauthorizedError
    end
  end
end
