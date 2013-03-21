class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :location
      t.string :description
      t.integer :category_id

      t.timestamps
    end
    add_index :places, :category_id
  end
end
