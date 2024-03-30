class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_sessions_count_today

  private

  def set_sessions_count_today
    now = Time.current
    end_of_day = now.end_of_day
    @sessions_count_today = Session.where("start_time >= ? AND end_time <= ?", now, end_of_day).count
  end

end
