class SessionsController < ApplicationController
  before_action :set_session, only: %i[ show edit update destroy rsvp ]

  # GET /sessions or /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1 or /sessions/1.json
  def show
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


  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions or /sessions.json
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

  def join
    if @session.started? && @session.users.include?(current_user)
      # Logic to let user join the session
      # This could involve redirecting to a page where the session is conducted
      # or simply rendering a view with session details.
    else
      redirect_to @session, alert: "You cannot join this session."
    end
  end

  # PATCH/PUT /sessions/1 or /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to session_url(@session), notice: "Session was successfully updated." }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1 or /sessions/1.json
  def destroy
    @session.destroy!

    respond_to do |format|
      format.html { redirect_to sessions_url, notice: "Session was successfully destroyed." }
      format.json { head :no_content }
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
