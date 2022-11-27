RSpec.shared_context 'dates' do
  let(:hour) { 12 }
  let(:minutes) { 30 }
  let(:seconds) { 0o0 }
  let(:last_monday) { DateTime.new(2022, 11, 14, hour, minutes, seconds) }
  let(:last_tuesday) { DateTime.new(2022, 11, 15, hour, minutes, seconds) }
  let(:last_wednesday) { DateTime.new(2022, 11, 16, hour, minutes, seconds) }
  let(:last_thursday) { DateTime.new(2022, 11, 17, hour, minutes, seconds) }
  let(:last_friday) { DateTime.new(2022, 11, 18, hour, minutes, seconds) }
  let(:last_saturday) { DateTime.new(2022, 11, 19, hour, minutes, seconds) }
  let(:last_last_sunday) { DateTime.new(2022, 11, 20, hour, minutes, seconds) }

  let(:monday) { DateTime.new(2022, 11, 21, hour, minutes, seconds) }
  let(:tuesday) { DateTime.new(2022, 11, 22, hour, minutes, seconds) }
  let(:wednesday) { DateTime.new(2022, 11, 23, hour, minutes, seconds) }
  let(:thursday) { DateTime.new(2022, 11, 24, hour, minutes, seconds) }
  let(:friday) { DateTime.new(2022, 11, 25, hour, minutes, seconds) }
  let(:saturday) { DateTime.new(2022, 11, 26, hour, minutes, seconds) }
  let(:sunday) { DateTime.new(2022, 11, 27, hour, minutes, seconds) }

  let(:next_monday) { DateTime.new(2022, 11, 28, hour, minutes, seconds) }
  let(:next_tuesday) { DateTime.new(2022, 11, 29, hour, minutes, seconds) }
  let(:next_wednesday) { DateTime.new(2022, 11, 30, hour, minutes, seconds) }
  let(:next_thursday) { DateTime.new(2022, 12, 0o1, hour, minutes, seconds) }
  let(:next_friday) { DateTime.new(2022, 12, 0o2, hour, minutes, seconds) }
  let(:next_saturday) { DateTime.new(2022, 12, 0o3, hour, minutes, seconds) }
  let(:next_sunday) { DateTime.new(2022, 12, 0o4, hour, minutes, seconds) }
end
