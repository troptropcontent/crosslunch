require 'rails_helper'
require 'support/shared_context/dates'

RSpec.describe 'RecurringEvents', type: :request do
  include ActiveSupport::Testing::TimeHelpers
  include_context 'dates'

  describe 'GET /recurring_event' do
    let(:path) { '/recurring_event' }
    describe 'when the request have no subdomain' do
      it 'raises a no routing error' do
        expect do
          get path
        end.to raise_error(ActionController::RoutingError)
      end
    end

    describe 'when the request have a subdomain' do
      let(:subdomain) { 'company-test' }
      before { host! "#{subdomain}.example.com" }
      describe 'when the user is not authenticated' do
        it 'redirects to the login page' do
          get path
          expect(response).to redirect_to user_session_path
        end
      end
      describe 'when the user is authenticated' do
        let(:user) { FactoryBot.create(:user) }
        before { sign_in user }
        describe 'when the company from subdomain is not found' do
          it 'raises a no routing error' do
            expect do
              get path
            end.to raise_error(ActionController::RoutingError)
          end
        end
        describe 'when the company from subdomain exists' do
          let!(:employee) { FactoryBot.create(:employee, company: company, user: user) }
          let!(:company) { FactoryBot.create(:company, name: subdomain) }
          describe 'when no recurring event exists' do
            it 'raises an error' do
              expect do
                get path
              end.to raise_error(ActiveRecord::RecordNotFound)
            end
          end
          describe 'when a recurring event have been set up' do
            let!(:recurring_event) do
              FactoryBot.create(
                :recurring_event,
                weekday: tuesday.wday,
                company: company,
                time: Time.current.change(min: 30, hour: 12)
              )
            end
            describe 'when event is happening today' do
              describe 'when the event is happening in more than two hours' do
                describe 'when an event already exists' do
                  let!(:event) do
                    FactoryBot.create(
                      :event,
                      recurring_event: recurring_event,
                      happens_at: today
                    )
                  end
                  let(:expected_global_variables) do
                    {
                      'event' => event,
                      'participation' => nil,
                      'participations_count' => 0,
                      'employee' => employee
                    }
                  end
                  it 'renders the upcoming_view and assigns the global variables correctly and do not creates an event' do
                    expect do
                      get path
                    end.not_to change(
                      Event, :count
                    )
                    expect(assigns).to include(**expected_global_variables)
                    expect(response).to render_template(:upcoming_event)
                  end
                end
                describe 'when no event exists' do
                  let(:expected_global_variables) do
                    {
                      'event' => Event.last,
                      'participation' => nil,
                      'participations_count' => 0,
                      'employee' => employee
                    }
                  end
                  it 'renders the upcoming_view and assigns the global variables correctly and creates an event' do
                    expect { get path }.to change(Event, :count).by(1)
                    expect(assigns).to include(**expected_global_variables)
                    expect(response).to render_template(:upcoming_event)
                  end
                end
              end

              describe 'when the event happens in two hours or happened in the last 2 hours ' do
                let(:now_hours) { 11 }
                let(:now_minutes) { 59 }
                let!(:event) { FactoryBot.create(:event, recurring_event: recurring_event, happens_at: today) }
                describe 'when the current_employee participates to the event' do
                  let!(:participation) { FactoryBot.create(:participation, event: event, employee: employee) }
                  describe 'whe the groups have been drawn yet' do
                    let(:expected_global_variables) do
                      {
                        'event' => event,
                        'group' => nil
                      }
                    end
                    it 'returns the groups_not_ready view' do
                      get path
                      expect(assigns).to include(**expected_global_variables)
                      expect(response).to render_template('events/show/groups_not_ready')
                    end
                  end
                  describe 'when the groups have been drawn' do
                    let!(:group) { FactoryBot.create(:group, event: event) }
                    let!(:groups_participation) do
                      FactoryBot.create(:groups_participation, group: group, participation: participation)
                    end
                    let(:expected_global_variables) do
                      {
                        'event' => event,
                        'group' => group,
                        'channel' => Channel.last,
                        'other_participants' => []
                      }
                    end
                    it 'returns the groups_done view' do
                      get path
                      expect(assigns).to include(**expected_global_variables)
                      expect(response).to render_template('events/show/groups_done')
                    end
                  end
                end
                describe 'when the current_employee does not participates' do
                  let!(:next_event) do
                    FactoryBot.create(
                      :event,
                      recurring_event: recurring_event,
                      happens_at: next_tuesday
                    )
                  end
                  let(:expected_global_variables) do
                    {
                      'event' => next_event,
                      'participation' => nil,
                      'participations_count' => 0,
                      'employee' => employee
                    }
                  end
                  it 'renders the upcoming_view and assigns the global variables correctly and creates an event' do
                    get path
                    expect(assigns).to include(**expected_global_variables)
                    expect(response).to render_template(:upcoming_event)
                  end
                end
              end
              describe 'when the event happened more than 2 hours ago' do
                let(:now_hours) { 17 }
                let(:now_minutes) { 0o0 }
                let!(:next_event) do
                  FactoryBot.create(
                    :event,
                    recurring_event: recurring_event,
                    happens_at: next_tuesday
                  )
                end
                let(:expected_global_variables) do
                  {
                    'event' => next_event,
                    'participation' => nil,
                    'participations_count' => 0,
                    'employee' => employee
                  }
                end
                it 'renders the upcoming_view and assigns the global variables correctly and creates an event' do
                  get path
                  expect(assigns).to include(**expected_global_variables)
                  expect(response).to render_template(:upcoming_event)
                end
              end
            end
            describe 'when event is not happening today' do
              let(:today) { wednesday }
              let!(:event) do
                FactoryBot.create(
                  :event,
                  recurring_event: recurring_event,
                  happens_at: next_tuesday
                )
              end
              let(:expected_global_variables) do
                {
                  'event' => event,
                  'participation' => nil,
                  'participations_count' => 0,
                  'employee' => employee
                }
              end
              it 'renders the upcoming_view and assigns the global variables correctly and creates an event' do
                get path
                expect(assigns).to include(**expected_global_variables)
                expect(response).to render_template(:upcoming_event)
              end
            end
          end
        end
      end
    end
  end
end
