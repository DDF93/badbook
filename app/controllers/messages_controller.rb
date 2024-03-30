class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end
  end

  def initiate_call
    @session = Session.find_by(id: params[:sessionId])
    @chatroom = Chatroom.find_by(session_id: params[:sessionId])
    if @chatroom
      ChatroomChannel.broadcast_to(
        @chatroom,
        action: 'execute_function',
        function_name: 'handleInitiateCall',
        room_url: @session.room_url,
      )
      head :ok
    else
      render json: { error: 'Chatroom not found' }, status: :not_found
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
