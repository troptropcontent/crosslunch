# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_context/dates'
module RecurringEvents
  RSpec.describe FindViewAndEvent, type: :actor do
    include ActiveSupport::Testing::TimeHelpers
    include_context 'dates'
    describe '.call' do
      subject { described_class.call(employee: employee, recurring_event: recurring_event) }
      let!(:company) { FactoryBot.create(:company) }
      let!(:employee) { FactoryBot.create(:employee, company: company) }

      let!(:recurring_event) { FactoryBot.create(:recurring_event, company: company, weekday: weekday) }
      let!(:event) { FactoryBot.create(:event, recurring_event: recurring_event, happens_at: tuesday) }
      let!(:weekday) { :tuesday }

      describe 'When the event is not happening today' do
        it 'returns the upcoming_event view' do
          travel_to wednesday do
            expect(subject.view).to eq(:upcoming_event)
          end
        end
        it 'returns the next event' do
          travel_to wednesday do
            expect(subject.event.happens_at).to eq(next_tuesday)
          end
        end
      end
      describe 'When the event is happening today' do
        context 'when there is more than two hours before the event' do
          it 'returns the upcoming_event view' do
            travel_to tuesday - 3.hours do
              expect(subject.view).to eq(:upcoming_event)
            end
          end
          it 'returns the event that is happening today' do
            travel_to tuesday - 3.hours do
              expect(subject.event.happens_at).to eq(tuesday)
            end
          end
        end
        context 'when we are between two hours before and two hours after the event' do
          context 'when the employee is participating' do
            let!(:participation) { FactoryBot.create(:participation, event: event, employee: employee) }
            it 'returns the current_event view' do
              travel_to tuesday do
                expect(subject.view).to eq(:current_event)
              end
            end
            it 'returns the event that is happening today' do
              travel_to tuesday do
                expect(subject.event.happens_at).to eq(tuesday)
              end
            end
          end
          context 'when the employee is not participating' do
            it 'returns the upcoming_event view' do
              travel_to tuesday do
                expect(subject.view).to eq(:upcoming_event)
              end
            end
            it 'returns the next event' do
              travel_to tuesday do
                expect(subject.event.happens_at).to eq(next_tuesday)
              end
            end
          end
        end
        context 'when we are more than two hours after the event' do
          it 'returns the upcoming_event view' do
            travel_to tuesday + 3.hours do
              expect(subject.view).to eq(:upcoming_event)
            end
          end
          it 'returns the next event' do
            travel_to tuesday + 3.hours do
              expect(subject.event.happens_at).to eq(next_tuesday)
            end
          end
        end
      end
    end
  end
end
