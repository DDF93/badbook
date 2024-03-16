class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :session
  validates :user_id, uniqueness: { scope: :session_id, message: "You are already attending this session." }
end
