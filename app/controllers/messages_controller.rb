class MessagesController < ApplicationController
  include CompanyController
  def create
    @message = Message.new(message_params)
    @channel = @message.channel
    @new_message = Message.new(channel: @channel, employee: @message.employee)
    if @message.save
      respond_to do |format|
        format.html { redirect_to channel_path(@channel) }
        format.turbo_stream
      end

    else
      @event = @channel.event
      @recurring_event = @event.recurring_event
      @messages = @channel.messages
      @employee = current_employee

      render 'channels/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :employee_id, :channel_id).compact_blank
  end
end
