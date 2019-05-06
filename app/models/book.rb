class Book < ApplicationRecord
  validates_presence_of :title, :author, :pages, :year, :cover_url

  has_many :author_books
  has_many :authors, through: :author_books
end
