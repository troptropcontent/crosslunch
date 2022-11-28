require 'active_support/testing/time_helpers'
class RecurringEventsController < ApplicationController
  before_action :authenticate_employee
  before_action :require_subdomain
  before_action :load_company
  before_action :load_recurring_event
  include ActiveSupport::Testing::TimeHelpers
  def show
    actor = RecurringEvents::FindViewAndEvent.call(employee: current_employee,
                                                   recurring_event: @recurring_event)
    if actor.view == :current_event
      render_current_event_view(actor)
    else
      render_upcoming_event_view(actor)
    end
  end

  private

  def load_recurring_event
    @recurring_event = @company.recurring_event
  end

  def render_current_event_view(actor)
    # TO DO
    @event = actor.event
    @group = current_employee.group_for(@event)
    @other_participants = @group.participations.where.not(employee: current_employee).extract_associated(:employee)
    @channel = @group.channel || @group.create_channel
    render :current_event
  end

  def render_upcoming_event_view(actor)
    @event = actor.event
    @participation = @event.participations.find_by(employee: current_employee)
    @participations_count = @event.participations.count
    @employee = current_employee

    render :upcoming_event
  end
end
