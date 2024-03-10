require 'open-uri'
require 'json'

def get_books_by_genre(genre)
  book_ids = []
  url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{genre}&maxResults=20"
  data = URI.open(url).read
  book_json = JSON.parse(data)
  book_json["items"].each do |book|
  book_ids << book["id"]
  end
  books = []
  book_ids.each do |book_id|
    id_data = URI.open("https://www.googleapis.com/books/v1/volumes/#{book_id}").read
    id_json = JSON.parse(id_data)

    title = id_json.dig("volumeInfo", "title")
    authors = id_json.dig("volumeInfo", "authors")&.join(", ")
    published_date = id_json.dig("volumeInfo", "publishedDate")
    description = id_json.dig("volumeInfo", "description")
    image_url = id_json.dig("volumeInfo", "imageLinks", "thumbnail")
    pp image_url
    book_add = {
      google_id: book_id,
      title: title,
      author: authors,
      date: published_date,
      description: description,
      image_url: image_url
  }
    books << book_add
    # pp book_add[:description]
  end
  return books
end

get_books_by_genre('Horror')
