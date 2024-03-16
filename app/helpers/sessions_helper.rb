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

  def session_countdown(start_time)
    return "Live now" if Time.current >= start_time && Time.current <= start_time + 1.hour # Adjust duration as needed

    time_difference = start_time - Time.current
    if time_difference > 1.day
      "Tomorrow at #{start_time.strftime('%-l:%M%p')}" # Adjust format as needed
    elsif time_difference > 0
      "In #{distance_of_time_in_words(Time.current, start_time)}"
    else
      "Expired"
    end
  end

  def session_capacity_text(session)
    spots_left = session.capacity - session.attendees.count # Adjust based on your model associations
    if spots_left <= 0
      "Full"
    else
      "#{spots_left} spots left"
    end
  end
end
