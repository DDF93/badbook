require 'json'
require 'open-uri'

User.create!(
  email: "admin@admin.com",
  password: "asdfgh"
)

bookclub_collection = ["I12oPwAACAAJ", "u7XrDwAAQBAJ", "xDtkEAAAQBAJ", "49nUEAAAQBAJ", "hIx4EAAAQBAJ", "tkZFEAAAQBAJ", "Es_PCwAAQBAJ", "hxL2qWMAgv8C", "jVB1DwAAQBAJ", "nNjTDwAAQBAJ", "wxBbEAAAQBAJ", "cpAREAAAQBAJ", "OyCtDwAAQBAJ", "iBg_EAAAQBAJ", "lGjFtMRqp_YC"]

romance_books = [  "IGkwDwAAQBAJ","1I1xDwAAQBAJ",  "JAzxznMKiq4C",  "Xb2GEAAAQBAJ",  "jwCVEAAAQBAJ",  "crZ1EAAAQBAJ",  "JXW7DwAAQBAJ",  "NlYD0AEACAAJ",  "Ra7tBgAAQBAJ",  "xT44AQAAQBAJ"]

crime_books = ["hxL2qWMAgv8C", "7AiTEAAAQBAJ", "M8h6EAAAQBAJ", "bL6LEAAAQBAJ", "tpZcDwAAQBAJ", "nXrxGCVd9UoC", "z7SnEAAAQBAJ", "3rOaEAAAQBAJ", "gQisEAAAQBAJ", "a6NnDwAAQBAJ"]

science_fiction_books = ["Nv-qDwAAQBAJ", "0OidDwAAQBAJ", "NljT2Bn3Y-wC", "52k6DwAAQBAJ", "TOMDq0vqXIQC", "IGvdhaVC5QwC", "ThS9hnCaNmkC", "uiVHDwAAQBAJ", "eCIFEAAAQBAJ", "iEiHEAAAQBAJ"]




def books_by_id(bookshelf_name, initial_books)

  bookshelf = Bookshelf.new(name: bookshelf_name, user_id: 1)
  bookshelf.save


  initial_books.each do |book_id|

      data = URI.open("https://www.googleapis.com/books/v1/volumes/#{book_id}").read
      book_json = JSON.parse(data)

      title = book_json.dig("volumeInfo", "title")
      authors = book_json.dig("volumeInfo", "authors")&.join(", ")
      published_date = book_json.dig("volumeInfo", "publishedDate")
      description = book_json.dig("volumeInfo", "description")

      book = Book.new(
        google_id: book_id,
        title: title,
        author: authors,
        date: published_date,
        description: description,
        image_url: book_json.dig("volumeInfo", "imageLinks", "thumbnail")
      )
    book.save
    BookshelfBook.create(bookshelf_id: bookshelf.id, book_id: book.id)

    end
end


books_by_id("bookclub_collection", bookclub_collection)
books_by_id("romance_books", romance_books)
books_by_id("crime_books", crime_books)
books_by_id("science_fiction_books", science_fiction_books)




Chatroom.create!(name: "to make it work for now")


# def get_books_by_genre(genre)
#   book_ids = []
#   url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{genre}&maxResults=20"

#   begin
#     data = URI.open(url).read
#   rescue OpenURI::HTTPError => e
#     if e.message.include?('429')
#       sleep(10)
#       retry
#     else
#       # Handle other HTTP errors
#       puts "HTTP Error: #{e.message}"
#       return []
#     end
#   end

#   book_json = JSON.parse(data)
#   return [] unless book_json["items"]

#   books = []
#   book_json["items"].each do |book|
#     book_ids << book["id"]
#   end

#   book_ids.each do |book_id|
#     begin
#       id_data = URI.open("https://www.googleapis.com/books/v1/volumes/#{book_id}").read
#     rescue OpenURI::HTTPError => e
#       if e.message.include?('429')
#         sleep(10)
#         retry
#       else
#         puts "HTTP Error: #{e.message}"
#         next
#       end
#     end

#     id_json = JSON.parse(id_data)
#     title = id_json.dig("volumeInfo", "title")
#     authors = id_json.dig("volumeInfo", "authors")&.join(", ")
#     published_date = id_json.dig("volumeInfo", "publishedDate")
#     description = id_json.dig("volumeInfo", "description")
#     image_url = id_json.dig("volumeInfo", "imageLinks", "thumbnail")

#     Book.create(
#       google_id: book_id,
#       title: title,
#       author: authors,
#       date: published_date,
#       description: description,
#       image_url: image_url,
#       genre: genre
#     )
#   end
# end

# get_books_by_genre('Romance')
# get_books_by_genre('Crime')
# get_books_by_genre('Vampire')
# get_books_by_genre('Humor')
# get_books_by_genre('Horror')
# get_books_by_genre('Science Fiction')
# get_books_by_genre('Fantasy')
# get_books_by_genre('Mystery')
# get_books_by_genre('Thriller')
# get_books_by_genre('Historical Fiction')

# seeding some users and adding them to sessions
10.times do |i|
  User.create!(
    email: "user#{i}@example.com",
    password: "password"
  )
end

# seeding sessions
books = Book.all
users = User.all

books.each do |book|
  rand(1..5).times do
    start_time = rand(1..14).days.from_now.beginning_of_day + rand(0..24).hours
    book.sessions.create!(
      book_id: book.id,
      user_id: users.sample.id,
      capacity: 15,
      start_time: start_time,
      video_link: 'http://example.com/session_dune',
      end_time: 2.months.from_now
    )
  end
end




# start_date = Date.today.beginning_of_week
# end_date = 2.months.from_now

# (start_date..end_date).select { |d| d.wday.in?([2, 4, 6]) }.each do |date|
#   Session.create!(
#     book_id: book1.id,
#     user_id: user.id,
#     capacity: 15,
#     start_time: date.to_time.change(hour: 19),
#     video_link: 'http://example.com/session_dune'
#   )
# end

# (start_date..end_date).select { |d| d.wday == 1 }.each do |date|
#   Session.create!(
#     book_id: book2.id,
#     user_id: user.id,
#     capacity: 15,
#     start_time: date.to_time.change(hour: 20),
#     video_link: 'http://example.com/session_twilight'
#   )
# end

# seeding attendees to sessions
users = User.all

Session.find_each do |session|
  Attendee.create!(
    session: session,
    user: users.sample
  )
end
