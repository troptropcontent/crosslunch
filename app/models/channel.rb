class Channel < ApplicationRecord
  belongs_to :group
  has_one :event, through: :group
  has_many :messages
end
