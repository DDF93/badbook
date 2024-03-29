module ApplicationHelper
  def user_is_host?(session, user)
    session.attendees.exists?(user_id: user.id, host: true)
  end
end
