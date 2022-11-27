require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.participates_to?' do
    subject { FactoryBot.create(:employee, company: company) }
    let(:company) { FactoryBot.create(:company) }
    let(:recurring_event) { FactoryBot.create(:recurring_event, company: company) }
    let(:event) { FactoryBot.create(:event, recurring_event: recurring_event) }
    describe 'when the employee is participating to the event' do
      let!(:participation) { FactoryBot.create(:participation, event: event, employee: subject) }
      it 'returns true' do
        expect(subject.participates_to?(event)).to be true
      end
    end
    describe 'when the employee is not participating to the event' do
      it 'returns false' do
        expect(subject.participates_to?(event)).to be false
      end
    end
  end
end
