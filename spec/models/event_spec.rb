require 'rails_helper'
require 'support/shared_context/dates'

RSpec.describe Event, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  include_context 'dates'
  describe '.next' do
    subject { event }
    let!(:event) { FactoryBot.create(:event, recurring_event: recurring_event, happens_at: wednesday) }
    let(:recurring_event) { FactoryBot.create(:recurring_event, weekday: :wednesday, time: wednesday) }
    describe 'when the next event already exists' do
      let!(:next_event) { FactoryBot.create(:event, recurring_event: recurring_event, happens_at: next_wednesday) }
      it 'it returns the next event' do
        expect(subject.next.happens_at).to eq(next_wednesday)
      end
      it 'does not create an event' do
        expect { subject.next }.not_to change(described_class, :count)
      end
    end
    describe 'when the next event does not already exist' do
      it 'it returns the next event' do
        expect(subject.next.happens_at).to eq(next_wednesday)
      end
      it 'does not create an event' do
        expect { subject.next }.to change(described_class, :count).by(1)
      end
    end
  end
end
