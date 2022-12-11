class Employee < ApplicationRecord
  belongs_to :company
  has_many :participations
  has_many :groups_participations, through: :participations
  has_many :groups, through: :groups_participations

  belongs_to :user
  delegate :first_name, to: :user
  delegate :last_name, to: :user

  def participates_to?(event)
    Participation.exists?(event: event, employee_id: id)
  end

  def group_for(event)
    event.groups.joins(groups_participations: { participation: :employee }).find_by(employee: { id: id })
  end
end
