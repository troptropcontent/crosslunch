require 'rails_helper'

RSpec.describe RecurringEvent, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  describe '.next_event' do
    subject { FactoryBot.create(:recurring_event, week_day: :monday) }
    let(:a_tuesday) { Date.new(2022, 11, 22) }
    let(:next_monday) { Date.new(2022, 11, 28) }
    describe 'when a event already exists' do
      let!(:event) { FactoryBot.create(:event, recurring_event: subject, date: next_monday) }
      it 'returns the alreay created event' do
        travel_to a_tuesday do
          expect(subject.next_event).to eq(event)
        end
      end
      it 'does not create an event' do
        travel_to a_tuesday do
          expect { subject.next_event }.to_not change { Event.count }
        end
      end
    end
    describe 'when there is no upcoming event' do
      it 'returns a new event for the next date' do
        travel_to a_tuesday do
          expect(subject.next_event.date).to eq(next_monday)
        end
      end
      it 'Creats an event' do
        travel_to a_tuesday do
          expect { subject.next_event }.to change { Event.count }.by(1)
        end
      end
    end
  end

  describe '.next_date' do
    subject { FactoryBot.build(:recurring_event, week_day: :monday) }
    let(:a_monday) { Date.new(2022, 11, 21) }
    let(:a_tuesday) { Date.new(2022, 11, 22) }
    let(:next_monday) { Date.new(2022, 11, 28) }
    describe 'when today is the week_day' do
      it 'returns the next occuring week_day' do
        travel_to a_monday do
          expect(subject.next_date).to eq(next_monday)
        end
      end
    end
    describe 'when today is not the week_day' do
      it 'returns the next occuring week_day' do
        travel_to a_tuesday do
          expect(subject.next_date).to eq(next_monday)
        end
      end
    end
  end
end
