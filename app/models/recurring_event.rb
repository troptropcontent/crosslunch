class RecurringEvent < ApplicationRecord
  validates :group_size, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :name, uniqueness: { scope: :company_id }
  belongs_to :company
  has_many :events
  enum :week_day, %i[sunday monday tuesday wednesday thursday friday saturday]

  def create_next_event
    next_event = events.find_by(date: next_date)
    return next_event if next_event

    events.create!(date: next_date)
  end

  def next_date
    Date.today.next_occurring(week_day.to_sym)
  end
end
