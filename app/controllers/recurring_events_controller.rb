class RecurringEventsController < ApplicationController
  include CompanyController
  before_action :load_recurring_event

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
    @recurring_event = RecurringEvent.find_by!(company: @company)
  end

  def render_current_event_view(actor)
    # TO DO
    @event = actor.event
    @group = current_employee.group_for(@event)
    if @group
      @other_participants = Employee.joins(:groups).where(groups: { id: @group.id }).where.not(id: current_employee.id).distinct
      @channel = Channel.find_or_create_by(group: @group)
      render 'events/show/groups_done'
    else
      render 'events/show/groups_not_ready'
    end
  end

  def render_upcoming_event_view(actor)
    @event = actor.event
    @participation = @event.participations.find_by(employee: current_employee)
    @participations_count = @event.participations.count
    @employee = current_employee

    render :upcoming_event
  end
end
