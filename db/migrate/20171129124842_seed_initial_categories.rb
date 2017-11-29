class SeedInitialCategories < ActiveRecord::Migration[5.1]
  def up
    Category.create(name: "Other")
    other = Category.last
    Job.all.each do |j|
      j.category = other
      j.save
    end
  end

  def down
  end
end
