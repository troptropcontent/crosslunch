class RecurringEvent < ApplicationRecord
  validates :group_size, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :name, uniqueness: { scope: :company_id }
  belongs_to :company
  has_many :events
  enum :weekday, %i[sunday monday tuesday wednesday thursday friday saturday]

  def next_event
    events.find_or_create_by(happens_at: next_date)
  end

  def next_date
    today = Date.today
    next_date = happening_today? ? today : today.next_occurring(weekday.to_sym)
    build_datetime(next_date, time)
  end

  def happening_today?
    Date.today.wday == RecurringEvent.weekdays[weekday]
  end

  private

  def build_datetime(date, time)
    DateTime.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end
end
