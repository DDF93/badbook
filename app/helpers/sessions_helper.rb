module SessionsHelper
  def capacity_info_class(session)
    'available' if session.has_capacity?
  end

  def session_action_class(session, user)
    case session.attendee_status(user)
    when "rsvp", "join"
      'action-available'
    when "checkmark"
      'action-taken'
    end
  end
end
