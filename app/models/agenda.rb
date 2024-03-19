class Agenda < ApplicationRecord
  belongs_to :session
  belongs_to :user

  def score
    (upvotes || 0) - (downvotes || 0)
  end
end
