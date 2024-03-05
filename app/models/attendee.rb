class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :session
end
