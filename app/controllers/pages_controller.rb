class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @books = Book.all
    @bookshelf = Bookshelf.where(user_id: current_user.id)
    if user_signed_in?
      read_books_shelf = current_user.bookshelves.find_by(name: 'Read Books')
      @read_books = read_books_shelf.present? ? read_books_shelf.books.to_a : []
    else
      @read_books = []
    end
  end

  def create
    @bookshelf = Bookshelf.new(bookshelf_params)
  end

end
