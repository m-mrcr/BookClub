class User < ApplicationRecord
  has_many :reviews
  validates_presence_of :username

  def review_count
    reviews.count
  end

  def self.most_prolific
    select("users.*, COUNT(reviews.id) AS review_count")
      .joins(:reviews)
      .group("users.id")
      .order("review_count DESC")
      .limit(3)
  end

  def self.usernames
    pluck(:username)
  end

end
