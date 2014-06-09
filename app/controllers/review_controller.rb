class ReviewController < ApplicationController
  before_filter :reviewer?
  allow_param(:id, {
    :only => :show
  })

  # ---------------------------------------------------------------------------
  # GET:/review
  # ---------------------------------------------------------------------------

  def index
    @submissions = Submission.all
  end

  # ---------------------------------------------------------------------------
  # GET:/review?id=?
  # ---------------------------------------------------------------------------

  def show
    unless @submission = Submission.find_by(:id => safe_params[:id])
      redirect_to :submissions, {
        :error => "Can't seem to find that submission."
      }
    end
  end
end
