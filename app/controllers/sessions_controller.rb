class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_session, only: %i[ show rsvp ]

  def index
    @sessions = Session.all
  end

  def show
    @session = Session.find(params[:id])
    @attendees = @session.attendees.includes(:user).map(&:user)
    @session_agendas = @session.agendas
  end

  def index
    @sessions = Session.all
  end

  def rsvp
    if current_user.attendees.exists?(session_id: @session.id)
      flash[:alert] = "You are already attending this session."
    elsif @session.attendees.count >= @session.capacity
      flash[:alert] = "The session has reached its capacity."
    else
      @attendee = @session.attendees.build(user: current_user)
      if @attendee.save
        flash[:notice] = "RSVP successful"
      else
        flash[:alert] = "Failed to RSVP"
      end
    end
  end

  def create
    @session = Session.new(session_params)

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
      params.require(:session).permit(:book_id, :user_id, :capacity, :start_time, :video_link)
    end
end
