class CreateEmployeesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :employees_users do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
