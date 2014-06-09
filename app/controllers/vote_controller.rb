class VoteController < ApplicationController
  before_filter :reviewer?, :already_voted?
  allow_param :commit, {
    :comment => [
      :text,
      :submission_id
    ]
  }, {
    :only => :create
  }

  def create
    case safe_params[:commit].downcase
    when "yes" then return vote_yes
    when "no"  then return vote_nos
    else
      redirect_to :back, {
        :error => "Invalid vote value given."
      }
    end
  end

  private
  def vote_yes
    @submission.votes.create({
      :approved => true,
      :account => @account
    })

    redirect_to :back, {
      :success => "Your vote has been registered."
    }
  end

  private
  def vote_nos
    if safe_params[:comment][:text].blank?
      redirect_to :back, {
        :error => "Please provide a comment why."
      }
    else
      @submission.votes.create(:account => @account)
      set_comment

      redirect_to :back, {
        :success => "Your vote has been registered."
      }
    end
  end

  private
  def set_comment
    @submission.comments.create({
      :account => @account,
      :text    => safe_params[:comment][:text]
    })
  end

  private
  def already_voted?
    @submission = Submission.find_by({
      :id => safe_params[:comment][:submission_id]
    })

    if ! @submission
      redirect_to :back, {
        :error => "Unknown submission."
      }
    else
      if @submission.votes.find_by(:account => @account)
        redirect_to :review, {
          :error => "You already voted on that submission."
        }
      end
    end
  end
end
