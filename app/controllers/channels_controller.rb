class ChannelsController < ApplicationController
  include CompanyController
  # GET  /channel/:id
  def show
    @channel = Channel.find(params[:id])
    @event = @channel.event
    @recurring_event = @event.recurring_event
    @messages = @channel.messages.reverse
    @employee = current_employee
    @message = Message.new(channel: @channel, employee: @employee)
  end
end
