class Author < ApplicationRecord
  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books
  validates_presence_of :name

  def self.alternate_authors(author)
    where.not(id: author.id)
  end

end
