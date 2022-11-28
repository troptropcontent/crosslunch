class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :employee
  validates :content, presence: true
end
