class RenameColumnPlaces < ActiveRecord::Migration
  def up
    change_column :places, :description, :text
  end

  def down
  end
end
