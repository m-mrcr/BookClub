class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    get_reviews
  end
end

private

def get_reviews
  case params[:sort]
  when "ascend"
    @reviews = @user.sort_oldest_first
  when "descend"
    @reviews = @user.sort_newest_first
  else
    @reviews = @user.sort_newest_first
  end
end
