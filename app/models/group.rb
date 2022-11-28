class Group < ApplicationRecord
  belongs_to :event
  has_many :groups_participations
  has_many :participations, through: :groups_participations
  has_one :channel
end
