class CreateRecurringEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :recurring_events do |t|
      t.string :name, null: false
      t.integer :week_day, null: false
      t.time :hour, null: false
      t.integer :group_size, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
