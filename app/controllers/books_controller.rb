class BooksController < ApplicationController
  def index
    @books = Book.all
    @initial_books = ["I12oPwAACAAJ", "u7XrDwAAQBAJ", "xDtkEAAAQBAJ",]
  end

  private

  def book_by_id
    data = URI.open('https://www.googleapis.com/books/v1/#{book_id}').read
    book_json = JSON.parse(data)
    Book.create(title: book_json['title'], author: book_json['author'])
  end
end
