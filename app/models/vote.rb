class Vote < ActiveRecord::Base
  belongs_to :account
  belongs_to :submission
end
