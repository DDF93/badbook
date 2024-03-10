class BooksController < ApplicationController
  before_action :set_book, only: [:mark_as_read]

  def index
    @books = Book.all
    # @horror_books = get_books_by_genre('Horror')
    @bookclub_collection = Book.all.sample(15)
    read_books_shelf = current_user.bookshelves.find_by(name: 'Read Books')
    @read_books = read_books_shelf.present? ? read_books_shelf.books.to_a : []
  end

  def show
    @book = Book.find(params[:id])
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
    @book = Book.find(params[:id])
  end
end
#   def get_books_by_genre(genre)
#     book_ids = []
#     url = "https://www.googleapis.com/books/v1/volumes?q=subject:#{genre}&maxResults=20"
#     data = URI.open(url).read
#     book_json = JSON.parse(data)
#     book_json["items"].each do |book|
#     book_ids << book["id"]
#     end
#     books = []
#     book_ids.each do |book_id|
#     book_instance = Book.new(
#       title: book_json.dig("volumeInfo", "title"),
#       author: book_json.dig("volumeInfo", "authors")&.join(", "),
#       date: book_json.dig("volumeInfo", "publishedDate"),
#       description: book_json.dig("volumeInfo", "description"),
#       p image_url: book_json.dig("volumeInfo", "imageLinks", "thumbnail"),

#       google_id: book_id
#     )

#     books << book_instance
#     end
#     return books
#   end
# end
