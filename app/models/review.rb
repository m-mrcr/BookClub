class Review < ApplicationRecord
  belongs_to :book
  validates_presence_of :headline, :body, :rating, :username
end
