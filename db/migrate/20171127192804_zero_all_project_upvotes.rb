class ZeroAllProjectUpvotes < ActiveRecord::Migration[5.1]
  def change
    Project.all.each do |project|
      project.upvotes = 0
      project.save
    end
  end
end
