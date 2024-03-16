class BookshelvesController < ApplicationController
  before_action :set_bookshelf, only: %i[ show edit update destroy ]

  # GET /bookshelves or /bookshelves.json
  def index
    @bookshelves = Bookshelf.where(user_id: current_user.id)
  end

  def add_book_to_bookshelf
    # Retrieve book_id and bookshelf_id from params
    book_id = params[:book_id]
    bookshelf_id = params[:bookshelf_id]

    # Log the received parameters for debugging
    Rails.logger.debug "Received book_id: #{book_id}, bookshelf_id: #{bookshelf_id}"

    # Perform logic to add book to bookshelf
    @bookshelf_book = BookshelfBook.new(book_id: book_id, bookshelf_id: bookshelf_id)
    # You might want to check if the book and bookshelf exist and if the current user owns the bookshelf
    if @bookshelf_book.save
      render json: { message: "Book added to bookshelf successfully" }, status: :ok
    else
      render json: { error: "Failed to add book to bookshelf", errors: @bookshelf_book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /bookshelves/1 or /bookshelves/1.json
  def show
  end

  # GET /bookshelves/new
  def new
    @bookshelf = Bookshelf.new
  end

  # GET /bookshelves/1/edit
  def edit
  end

  # POST /bookshelves or /bookshelves.json
  def create
    @bookshelf = Bookshelf.new(bookshelf_params)

    respond_to do |format|
      if @bookshelf.save
        format.html { redirect_to bookshelf_url(@bookshelf), notice: "Bookshelf was successfully created." }
        format.json { render :show, status: :created, location: @bookshelf }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookshelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookshelves/1 or /bookshelves/1.json
  def update
    respond_to do |format|
      if @bookshelf.update(bookshelf_params)
        format.html { redirect_to bookshelf_url(@bookshelf), notice: "Bookshelf was successfully updated." }
        format.json { render :show, status: :ok, location: @bookshelf }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookshelf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookshelves/1 or /bookshelves/1.json
  def destroy
    @bookshelf.destroy!

    respond_to do |format|
      format.html { redirect_to bookshelves_url, notice: "Bookshelf was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookshelf
      @bookshelf = Bookshelf.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bookshelf_params
      params.require(:bookshelf).permit(:name, :user_id)
    end
  end
