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

  describe "it has helper methods" do
    it "sorts user reviews based on review creation date" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Flopper")

      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_2.reviews.create(book: astronaut, body: "Enthralling", headline: 'review headline 3', rating: 5)
      user_1.reviews.create(book: css, body: "this is a review", headline: 'review headline 2', rating: 1)

      expect(Book.sort_avg_rating_best_to_worst).to eq([astronaut, css])
      expect(Book.sort_avg_rating_worst_to_best).to eq([css, astronaut])
      
      # expect(Book.sort_number_pages_most_to_least).to eq([astronaut, css])
      # expect(Book.sort_number_pages_least_to_most).to eq([css, astronaut])
      #
      # expect(Book.sort_number_reviews_most_to_least).to eq([astronaut, css])
      # expect(Book.sort_number_reviews_least_to_most).to eq([css, astronaut])
    end
  end
end
