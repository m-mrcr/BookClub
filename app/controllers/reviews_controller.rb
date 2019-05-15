class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    review = Review.new(review_params)
    username = user_params[:username].downcase.strip.titleize
    if User.usernames.include?(username) || !params[:review][:rating].to_i.between?(1,5)
      redirect_to new_book_review_path(@book.id)
    else
      review_user = User.find_or_create_by!(username: username)
      review_user.reviews << review
      @book.reviews << review
      review.save
      redirect_to book_path(params[:book_id])
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to user_path(params[:user_id])
  end

private

  def review_params
    params.require(:review).permit(:headline, :rating, :body)
  end

  def user_params
    params.permit(:username)
  end

end
