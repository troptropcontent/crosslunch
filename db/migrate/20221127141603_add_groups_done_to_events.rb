class AddGroupsDoneToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :groups_done, :boolean, null: false, default: false
  end
end
