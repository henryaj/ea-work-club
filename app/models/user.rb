class User < ApplicationRecord
  has_many :jobs
  has_many :projects

  def admin?
    admin
  end
end
