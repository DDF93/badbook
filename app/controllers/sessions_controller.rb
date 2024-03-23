class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_session, only: %i[ show rsvp ]

  def index
    @sessions = Session.all
    @upcoming_sessions = Session.where('end_time > ?', Time.current)
  end

  def show
    @session = Session.find(params[:id])
    @attendees = @session.attendees.includes(:user).map(&:user)
    @session_agendas = @session.agendas
    # @chatroom = Chatroom.find(params[:id])
    @chatroom = Chatroom.first
    @message = Message.new
  end

  def rsvp
    if current_user.attendees.exists?(session_id: @session.id)
      render json: { error: "You are already attending this session." }, status: :unprocessable_entity
    elsif @session.attendees.count >= @session.capacity
      render json: { error: "The session has reached its capacity." }, status: :unprocessable_entity
    else
      @attendee = @session.attendees.build(user: current_user)
      if @attendee.save
        spots_left = @session.capacity - @session.attendees.count
        session_path = book_session_path(book_id: @session.book.id, id: @session.id)
        render json: { spots_left: spots_left, session_path: session_path }, status: :created
      else
        render json: { error: "Failed to RSVP" }, status: :unprocessable_entity
      end
    end
  end

  def create
    @session = Session.new(session_params)
    @session.end_time = @session.start_time + 1.hour

    respond_to do |format|
      if @session.save
        format.html { redirect_to session_url(@session), notice: "Session was successfully created." }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def revoke_rsvp
    @book = Book.find(params[:book_id])
    @session = @book.sessions.find(params[:session_id])
    @attendee = @session.attendees.find_by(user_id: current_user.id)

    if @attendee.destroy
      spots_left = @session.capacity - @session.attendees.count
      render json: { message: "RSVP revoked successfully" }, status: :ok
    else
      render json: { error: "Failed to revoke RSVP" }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:book_id, :user_id, :capacity, :start_time, :end_time, :video_link)
    end
end
