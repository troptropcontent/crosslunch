# frozen_string_literal: true

require 'rails_helper'
module Events
  RSpec.describe FindGroupsSchema, type: :actor do
    describe '.call' do
      subject do
        described_class.call(group_size: group_size,
                             population_size: population_size)
      end
      let(:group_size) { 6 }
      let(:population_size) { 5 }
      describe 'when the group_size is smaller than the total population size' do
        it 'returns only one group of the total number of participants' do
          expect(subject.schema).to eq([population_size])
        end
      end
      describe 'when there no remaining participants' do
        let(:group_size) { 6 }
        let(:population_size) { 30 }
        it 'returns only groups of the group size' do
          expect(subject.schema).to eq([6, 6, 6, 6, 6])
        end
      end
      describe 'when there is remaining participants' do
        describe 'when the population size is huge' do
          let(:group_size) { 6 }
          let(:population_size) { 99 }
          it 'Spread the remaining number of participants with a new group' do
            expect(subject.schema).to eq([6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 5])
          end
        end
        describe 'when there is a lot of entire groups' do
          let(:group_size) { 6 }
          let(:population_size) { 33 }
          it 'Spread the remaining number of participants with a new group' do
            expect(subject.schema).to eq([6, 6, 6, 5, 5, 5])
          end
        end
        describe 'when there is just a few entire groups' do
          let(:group_size) { 6 }
          let(:population_size) { 14 }
          it 'Spread the remaining number of participants with a new group' do
            expect(subject.schema).to eq([5, 5, 4])
          end
        end
      end
    end
  end
end
