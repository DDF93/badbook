require "application_system_test_case"

class BookshelfBooksTest < ApplicationSystemTestCase
  setup do
    @bookshelf_book = bookshelf_books(:one)
  end

  test "visiting the index" do
    visit bookshelf_books_url
    assert_selector "h1", text: "Bookshelf books"
  end

  test "should create bookshelf book" do
    visit bookshelf_books_url
    click_on "New bookshelf book"

    fill_in "Book", with: @bookshelf_book.book_id
    fill_in "Bookshelf", with: @bookshelf_book.bookshelf_id
    click_on "Create Bookshelf book"

    assert_text "Bookshelf book was successfully created"
    click_on "Back"
  end

  test "should update Bookshelf book" do
    visit bookshelf_book_url(@bookshelf_book)
    click_on "Edit this bookshelf book", match: :first

    fill_in "Book", with: @bookshelf_book.book_id
    fill_in "Bookshelf", with: @bookshelf_book.bookshelf_id
    click_on "Update Bookshelf book"

    assert_text "Bookshelf book was successfully updated"
    click_on "Back"
  end

  test "should destroy Bookshelf book" do
    visit bookshelf_book_url(@bookshelf_book)
    click_on "Destroy this bookshelf book", match: :first

    assert_text "Bookshelf book was successfully destroyed"
  end
end
