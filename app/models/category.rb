class Category < ApplicationRecord
  has_many :jobs
  has_many :projects
  has_and_belongs_to_many :subscriptions

  def self.all_except_empty
    self.select do |c|
      c.projects.any? || c.jobs.any?
    end
  end

  def jobs_created_within_last_week
    jobs.select do |job|
      job.created_in_last_week?
    end
  end

  def projects_created_within_last_week
    projects.select do |project|
      project.created_in_last_week?
    end
  end
end
