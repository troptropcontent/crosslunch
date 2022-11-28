class Employee < ApplicationRecord
  belongs_to :company
  has_many :participations

  def participates_to?(event)
    Participation.exists?(event: event, employee_id: id)
  end

  def group_for(event)
    event.groups.joins(groups_participations: { participation: :employee }).find_by(employee: { id: id })
  end
end
