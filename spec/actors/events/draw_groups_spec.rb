# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_context/events/20_participants'
RSpec.describe Events::DrawGroups, type: :actor do
  describe '.call' do
    subject { described_class.call(event: event) }
    let(:recurring_event) { FactoryBot.create(:recurring_event, group_size: 7) }
    let!(:event) { FactoryBot.create(:event, recurring_event: recurring_event) }
    include_context '20 participants to the current event'
    it 'creates the groups and assign a group to each participations' do
      subject
      expect(event.groups.count).to eq(3)
      expect(event.participations.all?(&:group)).to eq(true)
    end
  end
end
