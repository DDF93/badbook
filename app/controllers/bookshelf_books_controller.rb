class BookshelfBooksController < ApplicationController
  before_action :set_bookshelf_book, only: %i[ show edit update destroy ]

  # GET /bookshelf_books or /bookshelf_books.json
  def index
    @bookshelf_books = BookshelfBook.all
  end

  # GET /bookshelf_books/1 or /bookshelf_books/1.json
  def show
  end

  # GET /bookshelf_books/new
  def new
    @bookshelf_book = BookshelfBook.new
  end

  # GET /bookshelf_books/1/edit
  def edit
  end

  # POST /bookshelf_books or /bookshelf_books.json
  def create
    @bookshelf_book = BookshelfBook.new(bookshelf_book_params)

    respond_to do |format|
      if @bookshelf_book.save
        format.html { redirect_to bookshelf_book_url(@bookshelf_book), notice: "Bookshelf book was successfully created." }
        format.json { render :show, status: :created, location: @bookshelf_book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookshelf_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookshelf_books/1 or /bookshelf_books/1.json
  def update
    respond_to do |format|
      if @bookshelf_book.update(bookshelf_book_params)
        format.html { redirect_to bookshelf_book_url(@bookshelf_book), notice: "Bookshelf book was successfully updated." }
        format.json { render :show, status: :ok, location: @bookshelf_book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookshelf_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookshelf_books/1 or /bookshelf_books/1.json
  def destroy
    @bookshelf_book.destroy!

    respond_to do |format|
      format.html { redirect_to bookshelf_books_url, notice: "Bookshelf book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookshelf_book
      @bookshelf_book = BookshelfBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bookshelf_book_params
      params.require(:bookshelf_book).permit(:book_id, :bookshelf_id)
    end
end
