class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_sessions_count_today

  private

  def set_sessions_count_today
    @sessions_count_today = Session.where(start_time: Date.current.beginning_of_day..Date.current.end_of_day).count
  end
end
