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

  def top_review
    reviews.order(:rating).reverse_order.limit(1)
  end

end

# select("books.title, AVG(reviews.rating) AS avg_rating").joins(:reviews).group(:title).order("avg_rating DESC")

# SELECT books.title, AVG(reviews.rating) AS avg_rating
# FROM books INNER JOIN reviews
# ON reviews.book_id = books.id
# GROUP BY books.title
# ORDER By avg_rating DESC;
