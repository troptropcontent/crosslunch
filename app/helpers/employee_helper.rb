module EmployeeHelper
  def full_name(employee)
    "#{employee.first_name} #{employee.last_name}"
  end
end
