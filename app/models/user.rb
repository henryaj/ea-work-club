class User < ApplicationRecord
  has_many :jobs
  has_many :projects
  acts_as_voter

  def admin?
    admin
  end
end
