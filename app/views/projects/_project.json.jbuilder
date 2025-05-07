json.extract! project, :id, :title, :subtitle, :description, :goal, :deadline, :category, :location, :image, :creator_id, :created_at, :updated_at
json.url project_url(project, format: :json)
