class Employee < ApplicationRecord
  belongs_to :company

  def participates_to?(event)
    Participation.exists?(event: event, employee_id: id)
  end
end
