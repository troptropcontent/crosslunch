class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.references :company, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
