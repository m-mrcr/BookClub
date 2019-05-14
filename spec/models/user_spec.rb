require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:username)}
  end

  describe "relationships" do
    it {should have_many :reviews}
  end

  describe "it has helper methods" do
    it "sorts user reviews based on review creation date" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_1.reviews.create(book: css, body: "this is a review", headline: 'review headline 2', rating: 1)

      expect(user_1.sort_oldest_first).to eq([user_1.reviews[0], user_1.reviews[1]])
      expect(user_1.sort_newest_first).to eq([user_1.reviews[1], user_1.reviews[0]])
    end

    it "gets review count from user object" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)

      expect(user_1.review_count).to eq(1)
    end

    it "finds username from a user object" do
      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Flopper")
      user_3 = User.create(username: "Flapper")
      user_4 = User.create(username: "Flupper")
      user_5 = User.create(username: "Flepper")

      expect(User.usernames).to include(user_1.username)
    end

    it "finds most prolific user" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_2 = User.create(username: "Flopper")
      user_2.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_2.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_3 = User.create(username: "Flapper")
      user_3.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_3.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_3.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_4 = User.create(username: "Flupper")
      user_4.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_4.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_4.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_4.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)

      expect(User.most_prolific).to eq([user_4, user_3, user_2])
      expect(User.most_prolific).to_not include(user_1)
    end
  end
end
