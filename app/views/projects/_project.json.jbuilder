json.extract! project, :id, :title, :description, :organisation, :owner_id, :owner_name, :contact_email, :created_at, :updated_at
json.url project_url(project, format: :json)
