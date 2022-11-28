class Event < ApplicationRecord
  belongs_to :recurring_event
  has_one :company, through: :recurring_event
  has_many :participations
  has_many :groups

  def next
    next_date = happens_at.next_occurring(recurring_event.weekday.to_sym)
    recurring_event.events.find_or_create_by(happens_at: next_date)
  end
end
