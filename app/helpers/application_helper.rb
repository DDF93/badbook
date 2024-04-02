module ApplicationHelper
  def user_is_host?(session, user)
    session.attendees.exists?(user_id: user.id, host: true)
  end
end

module SessionsHelper
  include ActionView::Helpers::DateHelper
  
  def session_countdown(start_time)
    if start_time.past?
      distance_of_time_in_words_to_now(start_time) + " ago"
    else
      "in " + distance_of_time_in_words_to_now(start_time)
    end
  end
end
