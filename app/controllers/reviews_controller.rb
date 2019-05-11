class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:book_id])
    review = Review.new(review_params)
    username = user_params[:username].titleize
    if User.usernames.include?(username) || !params[:review][:rating].to_i.between?(1,5)
      redirect_to new_book_review_path
    else
      formatted_username = username.downcase.strip.titleize
      review_user = User.find_or_create_by!(username: formatted_username)
      review_user.reviews << review
      @book.reviews << review
      review.save
      redirect_to book_path(params[:book_id])
    end
  end

private

  def review_params
    params.require(:review).permit(:headline, :rating, :body)
  end

  def user_params
    params.permit(:username)
  end

end
