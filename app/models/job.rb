class Job < ApplicationRecord
  enum time_commitment: [:not_specified, :part_time, :full_time]
end
