class CreateGroupsParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :groups_participations do |t|
      t.references :group, null: false, foreign_key: true
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
