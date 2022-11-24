class Participation < ApplicationRecord
  belongs_to :employee
  belongs_to :event
end
