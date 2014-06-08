class Comment < ActiveRecord::Base
  belongs_to :account
  belongs_to :submission
  belongs_to :comment
  has_many :comments
end
