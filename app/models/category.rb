class Category < ApplicationRecord
  has_many :jobs
  has_many :projects
end
