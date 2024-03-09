require 'json'
require 'open-uri'

initial_books = ["I12oPwAACAAJ", "u7XrDwAAQBAJ", "xDtkEAAAQBAJ", "49nUEAAAQBAJ", "hIx4EAAAQBAJ", "tkZFEAAAQBAJ", "Es_PCwAAQBAJ",
                 "hxL2qWMAgv8C", "jVB1DwAAQBAJ", "nNjTDwAAQBAJ", "wxBbEAAAQBAJ", "cpAREAAAQBAJ", "OyCtDwAAQBAJ", "iBg_EAAAQBAJ", "lGjFtMRqp_YC"]

initial_books.each do |book_id|
  begin
    data = URI.open("https://www.googleapis.com/books/v1/volumes/#{book_id}").read
    book_json = JSON.parse(data)

    title = book_json.dig("volumeInfo", "title")
    authors = book_json.dig("volumeInfo", "authors")&.join(", ")
    published_date = book_json.dig("volumeInfo", "publishedDate")
    description = book_json.dig("volumeInfo", "description")

    Book.create(
      google_id: book_id,
      title: title,
      author: authors,
      date: published_date,
      description: description,
      image_url: book_json.dig("volumeInfo", "imageLinks", "thumbnail")
    )
  rescue StandardError => e
    puts "Error occurred while processing book with ID #{book_id}: #{e.message}"
  end
end
