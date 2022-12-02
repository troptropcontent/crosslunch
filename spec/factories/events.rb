FactoryBot.define do
  factory :event do
    recurring_event
    happens_at { Date.today.midday }
  end
end
