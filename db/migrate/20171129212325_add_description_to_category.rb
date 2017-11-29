class AddDescriptionToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :description, :text
  end
end
