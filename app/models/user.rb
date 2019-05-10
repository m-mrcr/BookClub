class User < ApplicationRecord
  has_many :reviews
  validates_presence_of :username

  def review_count
    reviews.count
  end

  # def by_review_count
  #   user.joins(:reviews).select("COUNT(reviews.id)")
  #   count(:reviews)
  # end


# SELECT  users.username,
# COUNT(reviews.id) AS review_count
# FROM "users" INNER JOIN "reviews" ON "reviews"."user_id" = "users"."id"
# GROUP BY "users"."id"
# ORDER BY review_count DESC LIMIT(3);

  def self.most_prolific
    select("users.*, COUNT(reviews.id) AS review_count")
      .joins(:reviews)
      .group("users.id")
      .order("review_count DESC")
      .limit(3)
  end

end
