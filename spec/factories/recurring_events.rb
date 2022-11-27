FactoryBot.define do
  factory :recurring_event do
    name { 'MyString' }
    weekday { :monday }
    time { '2022-11-24 12:30:00' }
    group_size { 1 }
    company
  end
end
