class SessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_session, only: %i[ show rsvp ]
  before_action :set_book, only: [:show, :rsvp, :revoke_rsvp]

  def new
    @session = Session.new
    @session.book_id = params[:book_id] if params[:book_id]
  end

  def index
    @sessions = Session.all
    @upcoming_sessions = Session.where('start_time > ? OR start_time BETWEEN ? AND ?',
    Time.current,
    Time.current - 15.minutes,
    Time.current)
    .order(start_time: :asc)
  end

  def show
    @session = Session.find(params[:id])
    # Since book_id is passed as a parameter, use it to find the book
    @book = Book.find(params[:book_id])
    @upcoming_sessions = Session.where('start_time > ?', Time.current).order(start_time: :asc)
    @current_user = current_user
    @attendees = @session.attendees.includes(:user).map(&:user)
    @session_agendas = @session.agendas
    @current_user_attendee = @current_user.attendees.find_by(session_id: @session.id)
    @chatroom = Chatroom.find_by(session_id: @session.id) # Find the chatroom associated with the current session
    @message = Message.new
  end

  def rsvp
    @session = Session.find(params[:id])
    unless @session.attendees.exists?(user_id: current_user.id)
      if @session.attendees.count < @session.capacity
        @attendee = @session.attendees.build(user: current_user)
        if @attendee.save
          # Redirect to the session's detail page after successful join
          flash[:notice] = "You have successfully joined the session."
          redirect_to book_session_path(@session.book, @session)
        else
          # Redirect to the sessions list page if there was a problem joining
          flash[:alert] = "There was a problem joining the session."
          redirect_to sessions_path
        end
      else
        # Redirect to the sessions list page if the session is full
        flash[:alert] = "The session is full."
        redirect_to sessions_path
      end
    else
      # If the user is already an attendee, perhaps redirect them to the session's chatroom or the session's detail page
      flash[:notice] = "You are already an attendee of this session."
      redirect_to book_session_path(@session.book, @session)
    end
  end

  def create
    @session = Session.new(session_params)
    @session.end_time = @session.start_time + 1.hour
    @session.user = current_user

    if @session.save
      @session.attendees.create(user: current_user, host: true) # This line sets the host boolean to true
      redirect_to session_url(@session)
    else
      logger.debug @session.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def revoke_rsvp
    @book = Book.find(params[:book_id])
    @session = @book.sessions.find(params[:session_id])
    @attendee = @session.attendees.find_by(user_id: current_user.id)

    if @attendee.destroy
      spots_left = @session.capacity - @session.attendees.count
      render json: { }, status: :ok
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
      params.require(:session).permit(:title, :book_id, :capacity, :start_time, :video_link)
    end

    def set_book
      @book = Book.find(params[:book_id])
    end
end
