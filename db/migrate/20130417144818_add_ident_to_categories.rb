class AddIdentToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :identity, :string
  end
end
