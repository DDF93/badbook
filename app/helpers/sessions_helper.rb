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

  def session_countdown(start_time, include_expired = false)
    if include_expired && Time.current >= start_time + 1.hour
      return "Expired"
    elsif Time.current >= start_time && Time.current <= start_time + 1.hour
      return "Live now"
    else
      time_difference = start_time - Time.current
      if time_difference <= 0
        return "Expired"
      elsif time_difference <= 1.hour
        minutes_left = (time_difference / 60).to_i
        return "#{minutes_left} minutes"
      elsif start_time.to_date == Date.current
        return "Today at #{start_time.strftime('%-l:%M%p')}"
      elsif time_difference <= 1.day
        return "Tomorrow at #{start_time.strftime('%-l:%M%p')}"
      else
        days_left = (start_time.to_date - Date.current).to_i
        return "#{days_left} days"
      end
    end
  end

  def session_capacity_text(session)
    spots_left = session.capacity - session.attendees.count
    if spots_left <= 0
      "Full"
    else
      "#{spots_left} spots left"
    end
  end
end
