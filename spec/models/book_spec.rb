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
    describe "it has basic sorts" do
      before :each do
        @astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        @astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

        @css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        @css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

        @user_1 = User.create(username: "Flipper")
        @user_2 = User.create(username: "Flopper")

        @user_1.reviews.create(book: @astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
        @user_2.reviews.create(book: @astronaut, body: "Enthralling", headline: 'review headline 3', rating: 5)
        @user_1.reviews.create(book: @css, body: "this is a review", headline: 'review headline 2', rating: 1)
      end

      it "sorts user reviews based on average rating" do
        expect(Book.sort_avg_rating_best_to_worst).to eq([@astronaut, @css])
        expect(Book.sort_avg_rating_worst_to_best).to eq([@css, @astronaut])
      end

      it "sorts user reviews based on average rating" do
        expect(Book.sort_number_pages_most_to_least).to eq([@astronaut, @css])
        expect(Book.sort_number_pages_least_to_most).to eq([@css, @astronaut])
      end

      it "sorts user reviews based on number of reviews" do
        expect(Book.sort_number_reviews_most_to_least).to eq([@astronaut, @css])
        expect(Book.sort_number_reviews_least_to_most).to eq([@css, @astronaut])
      end
    end

    describe "it handles edge cases where no reviews are left for a book" do
      it "sorts user reviews based on number of reviews, including books with 0 reviews" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

        css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

        user_1 = User.create(username: "Flipper")
        user_2 = User.create(username: "Flopper")

        user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
        user_2.reviews.create(book: astronaut, body: "Enthralling", headline: 'review headline 3', rating: 5)

        expect(Book.sort_avg_rating_best_to_worst).to eq([astronaut, css])
        expect(Book.sort_avg_rating_worst_to_best).to eq([css, astronaut])

        expect(Book.sort_number_reviews_most_to_least).to eq([astronaut, css])
        expect(Book.sort_number_reviews_least_to_most).to eq([css, astronaut])
      end
    end

    describe "it can order books by rating" do
      it "can find average rating" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
        css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css.authors << Author.find_or_create_by(name: 'Chad Hadfield')
        user_1 = User.create(username: "Flapper")
        user_1.reviews.create(book: css, body: "Review 1", headline: 'Headline 1', rating: 1)
        user_2 = User.create(username: "Flepper")
        user_2.reviews.create(book: css, body: "Review 2", headline: 'Headline 2', rating: 2)
        user_3 = User.create(username: "Flipper")
        user_3.reviews.create(book: astronaut, body: "Review 3", headline: 'Headline 3', rating: 3)
        user_4 = User.create(username: "Flopper")
        user_4.reviews.create(book: astronaut, body: "Review 4", headline: 'Headline 4', rating: 4)
        user_5 = User.create(username: "Flupper")
        user_5.reviews.create(book: astronaut, body: "Review 5", headline: 'Headline 5', rating: 5)

        expect(css.average_rating).to eq(1.5)
        expect(astronaut.average_rating).to eq(4)
      end
      it "can find best and worst three books" do
        astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
        css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
        css.authors << Author.find_or_create_by(name: 'Chad Hadfield')
        hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        potter = Book.create(title: 'Harry Potter and the Order of the Phoenix', pages: 870, year: 2003, cover_url: 'https://images.gr-assets.com/books/1546910265l/2.jpg')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        potter.authors << Author.find_or_create_by(name: 'J.K. Rowling')
        user_1 = User.create(username: "Flapper")
        user_1.reviews.create(book: css, body: "Review 1", headline: 'Headline 1', rating: 1)
        user_2 = User.create(username: "Flepper")
        user_2.reviews.create(book: css, body: "Review 2", headline: 'Headline 2', rating: 1)
        user_3 = User.create(username: "Flipper")
        user_3.reviews.create(book: css, body: "Review 3", headline: 'Headline 3', rating: 1)
        user_4 = User.create(username: "Flopper")
        user_4.reviews.create(book: astronaut, body: "Review 4", headline: 'Headline 4', rating: 3)
        user_5 = User.create(username: "Flupper")
        user_5.reviews.create(book: astronaut, body: "Review 5", headline: 'Headline 5', rating: 3)
        user_6 = User.create(username: "Flapper")
        user_6.reviews.create(book: astronaut, body: "Review 1", headline: 'Headline 1', rating: 3)
        user_7 = User.create(username: "Flepper")
        user_7.reviews.create(book: hunger, body: "Review 2", headline: 'Headline 2', rating: 4)
        user_8 = User.create(username: "Flipper")
        user_8.reviews.create(book: hunger, body: "Review 3", headline: 'Headline 3', rating: 4)
        user_9 = User.create(username: "Flopper")
        user_9.reviews.create(book: hunger, body: "Review 4", headline: 'Headline 4', rating: 4)
        user_10 = User.create(username: "Flupper")
        user_10.reviews.create(book: potter, body: "Review 5", headline: 'Headline 5', rating: 5)
        user_11 = User.create(username: "Flupper")
        user_11.reviews.create(book: potter, body: "Review 5", headline: 'Headline 5', rating: 5)
        user_12 = User.create(username: "Flupper")
        user_12.reviews.create(book: potter, body: "Review 5", headline: 'Headline 5', rating: 5)

        expect(Book.three_best_books).to eq([potter, hunger, astronaut])
        expect(Book.three_worst_books).to eq([css, astronaut, hunger])
      end
    end
    
    describe "it can analyze reviews data"
    it "can find top and total reviews" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flapper")
      review_1 = user_1.reviews.create(book: astronaut, body: "Review 1", headline: 'Headline 1', rating: 1)
      user_2 = User.create(username: "Flepper")
      review_2 = user_2.reviews.create(book: astronaut, body: "Review 2", headline: 'Headline 2', rating: 2)
      user_3 = User.create(username: "Flipper")
      review_3 = user_3.reviews.create(book: astronaut, body: "Review 3", headline: 'Headline 3', rating: 3)
      user_4 = User.create(username: "Flopper")
      review_4 = user_4.reviews.create(book: astronaut, body: "Review 4", headline: 'Headline 4', rating: 4)
      user_5 = User.create(username: "Flupper")
      review_5 = user_5.reviews.create(book: astronaut, body: "Review 5", headline: 'Headline 5', rating: 5)

      expect(astronaut.total_reviews).to eq(5)
      expect(astronaut.top_review).to eq([review_5])
    end
  end
end
