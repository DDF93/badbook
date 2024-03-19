class AgendasController < ApplicationController
  before_action :find_session, only: [:create]
  before_action :set_agenda, only: [:upvote, :downvote]

  def create
    @agenda = @session.agendas.build(agenda_params)
    @agenda.user = current_user
    if @agenda.save
      redirect_to @session, notice: 'Agenda item submitted.'
    else
      redirect_to @session, alert: 'Unable to add agenda item.'
    end
  end

  def upvote
    @agenda = Agenda.find(params[:id])
    if @agenda.increment!(:upvotes)
      render json: { upvotes: @agenda.upvotes, downvotes: @agenda.downvotes }
    else
      render json: { status: "error" }, status: :unprocessable_entity
    end
  end

  def downvote
    @agenda = Agenda.find(params[:id])
    if @agenda.increment!(:downvotes)
      render json: { upvotes: @agenda.upvotes, downvotes: @agenda.downvotes }
    else
      render json: { status: "error" }, status: :unprocessable_entity
    end
  end


  private

  def find_session
    @session = Session.find(params[:session_id])
  end

  def agenda_params
    params.require(:agenda).permit(:content)
  end

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end
end
