class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    username = params[:review][:username].titleize
    if Review.usernames.include?(username) || params[:review][:rating].to_i != (1..5)
      redirect_to new_review_path
    else
      formatted_username = username.downcase.strip.titleize
      review_user = User.find_or_create_by!(username: formatted_username)
      review.user << review_user

      binding.pry
      review.save
      redirect_to book_path()
    end
  end

private

  def review_params
    params.require(:review).permit(:headline, :username, :rating, :body)
  end

end
