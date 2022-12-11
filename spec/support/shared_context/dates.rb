RSpec.shared_context 'dates' do
  let(:date_hour) { 12 }
  let(:date_minutes) { 30 }
  let(:date_seconds) { 0o0 }
  let(:last_monday) { DateTime.new(2022, 11, 14, date_hour, date_minutes, date_seconds) }
  let(:last_tuesday) { DateTime.new(2022, 11, 15, date_hour, date_minutes, date_seconds) }
  let(:last_wednesday) { DateTime.new(2022, 11, 16, date_hour, date_minutes, date_seconds) }
  let(:last_thursday) { DateTime.new(2022, 11, 17, date_hour, date_minutes, date_seconds) }
  let(:last_friday) { DateTime.new(2022, 11, 18, date_hour, date_minutes, date_seconds) }
  let(:last_saturday) { DateTime.new(2022, 11, 19, date_hour, date_minutes, date_seconds) }
  let(:last_last_sunday) { DateTime.new(2022, 11, 20, date_hour, date_minutes, date_seconds) }

  let(:monday) { DateTime.new(2022, 11, 21, date_hour, date_minutes, date_seconds) }
  let(:tuesday) { DateTime.new(2022, 11, 22, date_hour, date_minutes, date_seconds) }
  let(:wednesday) { DateTime.new(2022, 11, 23, date_hour, date_minutes, date_seconds) }
  let(:thursday) { DateTime.new(2022, 11, 24, date_hour, date_minutes, date_seconds) }
  let(:friday) { DateTime.new(2022, 11, 25, date_hour, date_minutes, date_seconds) }
  let(:saturday) { DateTime.new(2022, 11, 26, date_hour, date_minutes, date_seconds) }
  let(:sunday) { DateTime.new(2022, 11, 27, date_hour, date_minutes, date_seconds) }

  let(:next_monday) { DateTime.new(2022, 11, 28, date_hour, date_minutes, date_seconds) }
  let(:next_tuesday) { DateTime.new(2022, 11, 29, date_hour, date_minutes, date_seconds) }
  let(:next_wednesday) { DateTime.new(2022, 11, 30, date_hour, date_minutes, date_seconds) }
  let(:next_thursday) { DateTime.new(2022, 12, 0o1, date_hour, date_minutes, date_seconds) }
  let(:next_friday) { DateTime.new(2022, 12, 0o2, date_hour, date_minutes, date_seconds) }
  let(:next_saturday) { DateTime.new(2022, 12, 0o3, date_hour, date_minutes, date_seconds) }
  let(:next_sunday) { DateTime.new(2022, 12, 0o4, date_hour, date_minutes, date_seconds) }
  let(:today) { tuesday }
  let(:now) { today.change(min: now_minutes, hour: now_hours) }
  let(:now_hours) { 9 }
  let(:now_minutes) { 59 }
  around(:each) do |example|
    travel_to now do
      example.run
    end
  end 
end
