class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @books = Book.all
    if user_signed_in?
      @bookshelf = Bookshelf.where(user_id: current_user.id)
      read_books_shelf = current_user.bookshelves.find_by(name: 'Read Books')
      @read_books = read_books_shelf.present? ? read_books_shelf.books.to_a : []
    else
      @read_books = []
    end
  end

  def create
    @bookshelf = Bookshelf.new(bookshelf_params)
  end

  def my_library
    @sessions = current_user.sessions
    @bookshelves = Bookshelf.where(user_id: current_user.id)
  end

end
