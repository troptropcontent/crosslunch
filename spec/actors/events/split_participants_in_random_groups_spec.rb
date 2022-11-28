# frozen_string_literal: true

require 'rails_helper'
require 'support/shared_context/events/20_participants'
require 'support/shared_context/events/5_participants'

RSpec.describe Events::SplitParticipantsInRandomGroups, type: :actor do
  let(:schema) { [7, 7, 6] }
  subject { described_class.call(schema: schema, event: event) }
  describe '.call' do
    let!(:event) { FactoryBot.create(:event) }
    include_context '20 participants to the current event'
    it 'splits the participants into subgroups according to schema' do
      expect(subject.groups).to match(
        [
          [
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation)
          ],
          [
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation)
          ],
          [
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation),
            an_instance_of(Participation)
          ]
        ]
      )
    end
  end
end
