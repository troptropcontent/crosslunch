class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :recurring_event, null: false, foreign_key: true
      t.datetime :happens_at, null: false

      t.timestamps
    end
  end
end
