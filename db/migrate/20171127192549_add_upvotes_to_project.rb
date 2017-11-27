class AddUpvotesToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :upvotes, :int
  end
end
