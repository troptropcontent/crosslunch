class DropColumnsFirstNameLastNameFromEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :last_name
    remove_column :employees, :first_name
  end
end
