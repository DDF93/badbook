class BooksController < ApplicationController
  before_action :set_book, only: [:mark_as_read]
  before_action :set_session, only: [:show]

  def index
    @romance_books = Book.where(genre: 'Romance')
    @crime_books = Book.where(genre: 'Crime')
    @vampire_books = Book.where(genre: 'Vampire')
    @humor_books = Book.where(genre: 'Humor')
    @horror_books = Book.where(genre: 'Horror')
    @science_fiction_books = Book.where(genre: 'Science Fiction')
    @fantasy_books = Book.where(genre: 'Fantasy')
    @mystery_books = Book.where(genre: 'Mystery')
    @thriller_books = Book.where(genre: 'Thriller')
    @historical_fiction_books = Book.where(genre: 'Historical Fiction')
    @bookclub_collection = Book.all.limit(15)
    read_books_shelf = current_user.bookshelves.find_by(name: 'Read Books')
    @read_books = read_books_shelf.present? ? read_books_shelf.books.to_a : []
  end

  def show
    @book = Book.find(params[:id])
    @book_sessions = @book.sessions.includes(:attendees)

    clean_description = @book.description
                     .gsub(/\A"|"\Z/, '')
                     .gsub(/--Publisher's description\.\Z/, '')
                     .gsub(/<\/?b>|<\/?i>|<\/?p>|<br>/, '')
                     .strip

    sentence_case_description = clean_description.downcase.capitalize
    preview_characters = sentence_case_description[0...230]
    description_longer_than_250_characters = sentence_case_description.length > 230

    @preview_description = preview_characters
    @full_description = sentence_case_description
    @description_longer_than_250 = description_longer_than_250_characters
  end

  def mark_as_read
    @read_books << @book
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully marked as read.' }
      format.json { head :no_content }
    end
  end

private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_session
    @session = Session.find(params[:id])
  end









  # def get_books_by_genre(genre)
  #   book_ids = []
  #   url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{genre}&maxResults=20"

  #   begin
  #     data = URI.open(url).read
  #   rescue OpenURI::HTTPError => e
  #     if e.message.include?('429')
  #       sleep(5)  # Back off for 5 seconds before retrying
  #       retry
  #     else
  #       # Handle other HTTP errors
  #       puts "HTTP Error: #{e.message}"
  #       return []  # Return an empty array if there's an error
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
  #         sleep(5)  # Back off for 5 seconds before retrying
  #         retry
  #       else
  #         # Handle other HTTP errors
  #         puts "HTTP Error: #{e.message}"
  #         next  # Continue to the next book ID if there's an error
  #       end
  #     end

  #     id_json = JSON.parse(id_data)
  #     title = id_json.dig("volumeInfo", "title")
  #     authors = id_json.dig("volumeInfo", "authors")&.join(", ")
  #     published_date = id_json.dig("volumeInfo", "publishedDate")
  #     description = id_json.dig("volumeInfo", "description")
  #     image_url = id_json.dig("volumeInfo", "imageLinks", "thumbnail")

  #     book_add = {
  #       google_id: book_id,
  #       title: title,
  #       author: authors,
  #       date: published_date,
  #       description: description,
  #       image_url: image_url
  #     }
  #     books << book_add
  #   end
  # end
end
