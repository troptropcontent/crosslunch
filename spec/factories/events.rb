FactoryBot.define do
  factory :event do
    recurring_event
    happens_at { '2022-11-24 12:30:00' }
  end
end
