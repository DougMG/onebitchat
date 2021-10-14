class ChatChannel < ApplicationCable::Channel
  delegate  :ability, to: :connection
  protected :ability

  def subscribed
    return unless authorize_and_set_chat

    stream_from "#{params[:team_id]}_#{params[:type]}_#{@chat}"
  end

  def receive(data)
    @message = Message.new(body: data['message'], user: current_user)
    @record.messages << @message
  end

  private

  def authorize_and_set_chat
    case params[:type]
    when 'channels'
      @record = Channel.find(params[:id])
    when 'talks'
      @record = Talk.find_by(user_one_id: [params[:id], current_user.id], user_two_id: [params[:id], current_user.id], team: params[:team_id])
    else
      @chat = @record.id
      ability.can?(:read, @record) ? true : false
    end
  end
end
