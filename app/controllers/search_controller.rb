class SearchController < ApplicationController
      def index
      read_books_shelf = current_user.bookshelves.find_by(name: 'Read Books')
      @read_books = read_books_shelf.present? ? read_books_shelf.books.to_a : []

      if params[:query].present?
        @books = Book.search_book(params[:query])
      else
        @books = Book.all
      end
    end
end
