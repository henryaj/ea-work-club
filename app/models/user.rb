class User < ApplicationRecord
  has_many :jobs
  has_many :projects
  has_many :sent_emails
  has_one :subscription, dependent: :destroy
  acts_as_voter

  def admin?
    admin
  end

  def all_subscription_names
    subscription.categories.map(&:name)
  end

  def subscribed?
    subscription.present?
  end
  
  def jobs_needing_renewal
    jobs.select { |i| i.needs_renewal_soon? }
  end

  def projects_needing_renewal
    projects.select { |i| i.needs_renewal_soon? }
  end
end
