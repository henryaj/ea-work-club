class AddCategoryIdToProjectsAndJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :category_id, :bigint
    add_column :jobs, :category_id, :bigint
  end
end
