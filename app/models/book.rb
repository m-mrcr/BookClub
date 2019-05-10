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

end
