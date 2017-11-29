class AddJobsAndProjectsHaveACategory < ActiveRecord::Migration[5.1]
  def change
    create_join_table :projects, :categories
    create_join_table :jobs, :categories
  end
end
