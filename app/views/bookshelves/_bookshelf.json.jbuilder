json.extract! bookshelf, :id, :name, :user_id, :created_at, :updated_at
json.url bookshelf_url(bookshelf, format: :json)
