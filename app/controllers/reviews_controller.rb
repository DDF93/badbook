class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: %i[edit update destroy]

  def index
    @reviews = Review.all
  end

  def show
  end

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def edit
    @book = @review.book
  end

  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:book_id])
    @review.book_id = @book.id
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(@book), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to book_path(@review.book.id), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @review.destroy
    redirect_to book_path(@review.book), notice: "Review was successfully destroyed."
  end


  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:book_id, :user_id, :rating, :description)
    end

    def authorize_user
      unless @review.user == current_user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
    end

  end

end
