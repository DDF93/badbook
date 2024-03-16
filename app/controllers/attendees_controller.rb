class AttendeesController < ApplicationController
  before_action :set_attendee, only: %i[ show edit update destroy ]
  before_action :find_session

  def index
    @attendees = Attendee.all
  end

  def show
  end

  def new
    @attendee = Attendee.new
  end

  def edit
  end

  def create
    if @session.attendees.count < @session.capacity
      attendee = @session.attendees.build(user: current_user)

      if attendee.save
        redirect_to @session, notice: "You're now attending the session."
      else
        redirect_to @session, alert: "Could not attend the session."
      end
    else
      redirect_to @session, alert: "Session is at full capacity."
    end
  end

  def destroy
    @session = Session.find(params[:session_id])
    @attendee = @session.attendees.find_by(user_id: current_user.id)
    if @attendee.destroy
      render json: { message: "RSVP revoked successfully" }, status: :ok
    else
      render json: { error: "Failed to revoke RSVP" }, status: :unprocessable_entity
    end
  end

private

def attendee_params
  params.require(:attendee).permit(:user_id, :session_id)
end


  # PATCH/PUT /attendees/1 or /attendees/1.json
  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to attendee_url(@attendee), notice: "Attendee was successfully updated." }
        format.json { render :show, status: :ok, location: @attendee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendees/1 or /attendees/1.json
  def destroy
    @attendee.destroy!

    respond_to do |format|
      format.html { redirect_to attendees_url, notice: "Attendee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_attendee
      @attendee = Attendee.find(params[:id])
    end

    def attendee_params
      params.require(:attendee).permit(:user_id, :session_id)
    end

    def find_session
      @session = Session.find(params[:session_id])
    end
end
