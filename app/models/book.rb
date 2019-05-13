class Book < ApplicationRecord
  has_many :reviews
  has_many :author_books
  has_many :authors, through: :author_books
  validates_presence_of :title, :pages, :year, :cover_url

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

  def self.sort_avg_rating_best_to_worst
    select("books.*, AVG(reviews.rating) AS average_book_rating")
      .joins(:reviews).group("books.id")
      .order("average_book_rating")
      .reverse_order

    # SELECT book_id, AVG(rating)
    # FROM books
    # JOIN reviews ON books.id = reviews.book_id
    # GROUP BY(book_id);
  end

  def self.sort_avg_rating_worst_to_best
    select("books.*, AVG(reviews.rating) AS average_book_rating")
      .joins(:reviews).group("books.id")
      .order("average_book_rating")
  end

  def sort_number_pages_most_to_least
  # def self.sort_number_pages_most_to_least ?????????
    order(:pages).reverse_order
  end

  def sort_number_pages_least_to_most
  # def self.sort_number_pages_least_to_most ?????????
    order(:pages)
  end

  def sort_number_reviews_most_to_least
    order(total_reviews)
    # order(reviews.count)
  end

  def sort_number_reviews_least_to_most
  end

end
