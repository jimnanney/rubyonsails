class Submission < ActiveRecord::Base
  belongs_to :account
  has_many :votes
  has_many :comments

  validates_presence_of :text
  validates_presence_of :title
end
