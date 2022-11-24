FactoryBot.define do
  factory :recurring_event do
    name { 'MyString' }
    week_day { 1 }
    hour { '2022-11-24 12:55:55' }
    group_size { 1 }
    company
  end
end
