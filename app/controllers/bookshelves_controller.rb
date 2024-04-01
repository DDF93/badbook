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
      render json: { }, status: :ok
    else
      render json: { error: "Failed to add book to bookshelf", errors: @bookshelf_book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def remove_book_from_bookshelf
    # Retrieve book_id and bookshelf_id from params
    book_id = params[:book_id]
    bookshelf_id = params[:bookshelf_id]

    # Log the received parameters for debugging
    Rails.logger.debug "Received book_id: #{book_id}, bookshelf_id: #{bookshelf_id}"

    # Perform logic to add book to bookshelf
    @bookshelf_book = BookshelfBook.find_by(book_id: book_id, bookshelf_id: bookshelf_id)
    # You might want to check if the book and bookshelf exist and if the current user owns the bookshelf
    if @bookshelf_book.destroy
      render json: { }, status: :ok
    else
      render json: { error: "Failed to remove book from bookshelf", errors: @bookshelf_book.errors.full_messages }, status: :unprocessable_entity
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
    @bookshelf = current_user.bookshelves.new(bookshelf_params)

    respond_to do |format|
      if @bookshelf.save
        format.json { render json: { bookshelf: @bookshelf }, status: :created }
      else
        format.json { render json: { error: @bookshelf.errors.full_messages.join(", ") }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookshelves/1 or /bookshelves/1.json
  def update
    respond_to do |format|
      if @bookshelf.update(bookshelf_params)
        format.html { redirect_to bookshelf_url(@bookshelf) }
        format.json { render :show, status: :ok, location: @bookshelf }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookshelf.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookshelf = Bookshelf.find(params[:id])
    @bookshelf.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@bookshelf) }
      format.html { redirect_to my_library_path }
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
