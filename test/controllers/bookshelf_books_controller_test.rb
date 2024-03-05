require "test_helper"

class BookshelfBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookshelf_book = bookshelf_books(:one)
  end

  test "should get index" do
    get bookshelf_books_url
    assert_response :success
  end

  test "should get new" do
    get new_bookshelf_book_url
    assert_response :success
  end

  test "should create bookshelf_book" do
    assert_difference("BookshelfBook.count") do
      post bookshelf_books_url, params: { bookshelf_book: { book_id: @bookshelf_book.book_id, bookshelf_id: @bookshelf_book.bookshelf_id } }
    end

    assert_redirected_to bookshelf_book_url(BookshelfBook.last)
  end

  test "should show bookshelf_book" do
    get bookshelf_book_url(@bookshelf_book)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookshelf_book_url(@bookshelf_book)
    assert_response :success
  end

  test "should update bookshelf_book" do
    patch bookshelf_book_url(@bookshelf_book), params: { bookshelf_book: { book_id: @bookshelf_book.book_id, bookshelf_id: @bookshelf_book.bookshelf_id } }
    assert_redirected_to bookshelf_book_url(@bookshelf_book)
  end

  test "should destroy bookshelf_book" do
    assert_difference("BookshelfBook.count", -1) do
      delete bookshelf_book_url(@bookshelf_book)
    end

    assert_redirected_to bookshelf_books_url
  end
end
