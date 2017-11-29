class Category < ApplicationRecord
  has_many :jobs
  has_many :projects

  def self.all_except_empty
    self.select do |c|
      c.projects.any? || c.jobs.any?
    end
  end
end
