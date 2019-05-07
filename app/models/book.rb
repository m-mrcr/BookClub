class Book < ApplicationRecord
  has_many :reviews
  has_many :author_books
  has_many :authors, through: :author_books
  validates_presence_of :title, :pages, :year, :cover_url
end
