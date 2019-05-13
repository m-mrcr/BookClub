class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  validates_presence_of :title, :pages, :year, :cover_url

  ################ BEGIN "NEEDS TESTS"########################

  def self.titles
    self.select(:title).pluck(:title)
  end

  def self.three_best_books
    joins(:reviews).group(:id).order("avg(reviews.rating) DESC").limit(3)
  end

  def self.three_worst_books
    joins(:reviews).group(:id).order("avg(reviews.rating)").limit(3)
  end

  def average_rating
    reviews.average(:rating)
  end

  def total_reviews
    reviews.count
  end

  def top_review
    reviews.order(:rating).reverse_order.limit(1)
  end
################ END "NEEDS TESTS"########################



  def self.sort_avg_rating_best_to_worst
    # $ rails dbconsle
    # We know we have to use join - essentially "books.reviews"
    # We want a table with books and average rating score
    # SELECT book_id, AVG(rating)
    # FROM books
    # JOIN reviews ON books.id = reviews.book_id
    # GROUP BY(book_id);

    # Once we have an SQL query, use $ puts joins(:reviews).to_sql as a starting point
    # Added coalesce to account for when books have no reviews
    select("books.*, COALESCE(AVG(reviews.rating), 0) AS average_book_rating")
      .left_outer_joins(:reviews)
      .group("books.id")
      .order("average_book_rating")
      .reverse_order
  end

  def self.sort_avg_rating_worst_to_best
    select("books.*, COALESCE(AVG(reviews.rating), 0) AS average_book_rating")
      .left_outer_joins(:reviews)
      .group("books.id")
      .order("average_book_rating")
  end

  def self.sort_number_pages_most_to_least
    order(:pages).reverse_order
  end

  def self.sort_number_pages_least_to_most
    order(:pages)
  end

  def self.sort_number_reviews_most_to_least
    select("books.*, COUNT(reviews) AS count_of_reviews")
      .left_outer_joins(:reviews)
      .group("books.id")
      .order("count_of_reviews")
      .reverse_order
  end

  def self.sort_number_reviews_least_to_most
    select("books.*, COUNT(reviews) AS count_of_reviews")
      .left_outer_joins(:reviews)
      .group("books.id")
      .order("count_of_reviews")
  end
end
