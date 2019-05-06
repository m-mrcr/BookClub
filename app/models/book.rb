class Book < ApplicationRecord

  validates_presence_of :title, :author, :pages, :year, :cover_url

end
