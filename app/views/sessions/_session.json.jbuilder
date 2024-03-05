json.extract! session, :id, :book_id, :user_id, :capacity, :start_time, :video_link, :created_at, :updated_at
json.url session_url(session, format: :json)
