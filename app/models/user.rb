class User < ApplicationRecord
  has_many :reviews
  validates_presence_of :username

  def user_review_count

  end

  def users_by_review_count

  end

  def self.most_prolific_users
    
  end

end
