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

# seeding attendees to sessions
users = User.all

Session.find_each do |session|
  Attendee.create!(
    session: session,
    user: users.sample
  )
end

10.times do |i|
  User.create!(
    email: Faker::Internet.email,
    password: "password"
  )
end


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

users = User.all

Session.find_each do |session|
  user = users.sample
  unless session.attendees.exists?(user_id: user.id)
    Attendee.create!(session: session, user: user)
  end
end
