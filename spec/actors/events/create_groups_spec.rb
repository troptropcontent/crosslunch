# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_context/events/20_participants'

RSpec.describe Events::CreateGroups, type: :actor do
  describe '.call' do
    let!(:event) { FactoryBot.create(:event) }
    include_context '20 participants to the current event'
    subject { described_class.call(groups: groups) }
    let(:groups) do
      [
        [participation_3, participation_6, participation_9],
        [participation_2, participation_4, participation_1],
        [participation_7, participation_10]
      ]
    end
    it 'creates the groups in the database' do
      expect { subject }.to change(Group, :count).by(3)
    end
    it 'creates the groups_participations in the database' do
      expect { subject }.to change(GroupsParticipation, :count).by(8)
    end
  end
end
