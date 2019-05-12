class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = Review.where(user_id: params[:id])
    case params[:sort]
    when "ascend"
      # require 'pry'; binding.pry
      @reviews = @reviews.order(:created_at)
    when "descend"
      # require 'pry'; binding.pry
      @reviews = @reviews.order(:created_at).reverse_order
    else
    end
  end

end
