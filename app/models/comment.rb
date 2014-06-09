class Comment < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  
  belongs_to :account
  belongs_to :submission
  belongs_to :comment
end
