class BooksController < ApplicationController
  before_action :set_book, only: [:mark_as_read]

  def index
    @books = Book.all
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
