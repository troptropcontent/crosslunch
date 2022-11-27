# frozen_string_literal: true

module RecurringEvents
  class FindViewAndEvent < Actor
    TIME_MARGIN = 2.hours.freeze
    input :recurring_event
    input :employee
    output :view
    output :event
    def call
      if recurring_event.happening_today?
        handle_event_happening_today
      else
        handle_event_not_happening_today
      end
    end

    private

    def handle_event_happening_today
      today_event = recurring_event.next_event
      if Time.current.before?(today_event.happens_at - TIME_MARGIN)
        self.view = :upcoming_event
        self.event = today_event
      elsif Time.current.after?(today_event.happens_at + TIME_MARGIN)
        self.view = :upcoming_event
        self.event = today_event.next
      elsif employee.participates_to?(today_event)
        self.view = :current_event
        self.event = today_event
      else
        self.view = :upcoming_event
        self.event = today_event.next
      end
    end

    def handle_event_not_happening_today
      self.view = :upcoming_event
      self.event = recurring_event.next_event
    end
  end
end
