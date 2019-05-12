class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    case params[:sort]
    when "ascend"
      # require 'pry'; binding.pry
      @reviews = Review.where(user_id: params[:id]).sort_oldest_first
    when "descend"
      # require 'pry'; binding.pry
      @reviews = Review.where(user_id: params[:id]).sort_newest_first
    else
      @reviews = Review.where(user_id: params[:id])
    end
  end

end
