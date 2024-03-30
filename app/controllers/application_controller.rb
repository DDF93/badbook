class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_sessions_count_today

  private

  def set_sessions_count_today
    @sessions_count_today = Session.where("DATE(start_time) = ?", Date.current).count
  end

end
