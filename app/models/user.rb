class User < ApplicationRecord
  has_many :reviews
  validates_presence_of :username

  def review_count
    reviews.count
  end

  def by_review_count
    user.joins(:reviews).select("COUNT(reviews.id)")
    count(:reviews)
  end


end
