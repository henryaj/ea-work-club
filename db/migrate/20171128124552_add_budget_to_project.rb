class AddBudgetToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :budget, :int
  end
end
