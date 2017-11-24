json.extract! job, :id, :title, :location, :description, :time_commitment, :organisation, :created_at, :updated_at
json.url job_url(job, format: :json)
