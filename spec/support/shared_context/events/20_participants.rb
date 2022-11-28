RSpec.shared_context '20 participants to the current event' do
  20.times do |i|
    let!("employee_#{i + 1}".to_sym) { FactoryBot.create(:employee, company: event.company) }
    let!("participation_#{i + 1}".to_sym) do
      FactoryBot.create(:participation, event: event, employee: send("employee_#{i + 1}".to_sym))
    end
  end
end
