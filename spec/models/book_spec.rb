require "rails_helper"

describe Book, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:year)}
    it {should validate_presence_of(:cover_url)}
  end

  describe "relationships" do
    it {should have_many :author_books}
    it {should have_many(:authors).through(:author_books)}
  end
end
