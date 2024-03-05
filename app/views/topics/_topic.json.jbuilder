json.extract! topic, :id, :session_id, :description, :user_id, :votes, :created_at, :updated_at
json.url topic_url(topic, format: :json)
