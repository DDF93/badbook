class Topic < ApplicationRecord
  belongs_to :session
  belongs_to :user
end
