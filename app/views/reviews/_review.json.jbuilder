json.extract! review, :id, :book_id, :user_id, :rating, :description, :created_at, :updated_at
json.url review_url(review, format: :json)
