require 'rails_helper'
require 'support/shared_context/dates'
RSpec.describe RecurringEvent, type: :model do
  include ActiveSupport::Testing::TimeHelpers
  include_context 'dates'

  describe '.next_event' do
    subject { FactoryBot.create(:recurring_event, weekday: :monday) }

    describe 'when the event is happening today' do
      describe 'when an event already exists' do
        let!(:event) { FactoryBot.create(:event, recurring_event: subject, happens_at: monday) }
        it 'returns the event that is happening today' do
          travel_to monday do
            expect(subject.next_event.happens_at).to eq(monday)
          end
        end
        it 'does not create an event' do
          travel_to monday do
            expect { subject.next_event }.not_to change(Event, :count)
          end
        end
      end
      describe 'when an event does not already exists' do
        it 'returns the event that is happening today' do
          travel_to monday do
            expect(subject.next_event.happens_at).to eq(monday)
          end
        end
        it 'creates an event' do
          travel_to monday do
            expect { subject.next_event }.to change(Event, :count).by(1)
          end
        end
      end
    end
    describe 'when the event is not happening today' do
      describe 'when an event already exists' do
        let!(:event) { FactoryBot.create(:event, recurring_event: subject, happens_at: next_monday) }
        it 'returns the next event' do
          travel_to tuesday do
            expect(subject.next_event.happens_at).to eq(next_monday)
          end
        end
        it 'does not create an event' do
          travel_to tuesday do
            expect { subject.next_event }.not_to change(Event, :count)
          end
        end
      end
      describe 'when an event does not already exists' do
        it 'returns the next event' do
          travel_to tuesday do
            expect(subject.next_event.happens_at).to eq(next_monday)
          end
        end
        it 'creates an event' do
          travel_to tuesday do
            expect { subject.next_event }.to change(Event, :count).by(1)
          end
        end
      end
    end
  end

  describe '.next_date' do
    subject { FactoryBot.build(:recurring_event, weekday: :monday) }
    describe 'when the recuring_event weekday is today' do
      it "returns today's date" do
        travel_to monday do
          expect(subject.next_date).to eq(monday)
        end
      end
    end
    describe 'when the recuring_event weekday is not today' do
      it "returns next occuring weekday's date" do
        travel_to tuesday do
          expect(subject.next_date).to eq(next_monday)
        end
      end
    end
  end

  describe '.happening_today?' do
    subject { FactoryBot.build(:recurring_event, weekday: :monday) }
    context 'when the event is happening today' do
      it 'returns true' do
        travel_to monday do
          expect(subject.happening_today?).to be true
        end
      end
    end
    context 'when the event is not happening today' do
      it 'returns false' do
        travel_to tuesday do
          expect(subject.happening_today?).to be false
        end
      end
    end
  end
end
