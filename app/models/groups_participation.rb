class GroupsParticipation < ApplicationRecord
  belongs_to :group
  belongs_to :participation
end
