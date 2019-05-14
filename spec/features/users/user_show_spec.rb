require "rails_helper"

describe "user clicks reviewer on any book review" do
  describe "user is directed to show page for that reviewer" do
    it "displays that reviewers name as a link" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it", headline: 'I have so many good things to say about this book', rating: 5)

      visit books_path

      within "#books" do
        click_link(astronaut.title)
      end

      within '#standard-reviews' do
        click_link(astronaut.reviews[0].user.username)
      end

      expect(current_path).to eq(user_path(astronaut.reviews[0].user.id))
    end

    it "displays all reviews for that user" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it", headline: 'I have so many good things to say about this book', rating: 5)

      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

      user_2 = User.create(username: "Fopper")
      user_2.reviews.create(book: css, body: "this is the body of a review", headline: 'this is the headline of a review', rating: 1)

      visit books_path

      within "#books" do
        click_link(astronaut.title)
      end

      within '#standard-reviews' do
        click_link(astronaut.reviews[0].user.username)
      end

      expect(page).to have_content(astronaut.reviews[0].user.username)
      expect(page).to have_content(astronaut.reviews[0].headline)
      expect(page).to have_content(astronaut.reviews[0].body)
      expect(page).to have_content(astronaut.reviews[0].book.title)

      expect(page).to_not have_content(css.reviews[0].user.username)
      expect(page).to_not have_content(css.reviews[0].headline)
      expect(page).to_not have_content(css.reviews[0].body)
      expect(page).to_not have_content(css.reviews[0].book.title)
    end

    it "sorts reviews oldest to newest" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_1.reviews.create(book: css, body: "this is a review", headline: 'review headline 2', rating: 1)

      visit books_path

      within "#books" do
        click_link(astronaut.title)
      end

      within '#standard-reviews' do
        click_link(astronaut.reviews[0].user.username)
      end

      click_link("Oldest to Newest")

      within '#all-reviews' do
        expect(page.all('li')[0]).to have_content(user_1.reviews.first.headline)
        expect(page.all('li')[1]).to have_content(user_1.reviews.last.headline)
      end
    end

    it "sorts reviews newest to oldest" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't know!", headline: 'review headline 1', rating: 5)
      user_1.reviews.create(book: css, body: "this is a review", headline: 'review headline 2', rating: 1)

      visit books_path
      within "#books" do
        click_link(astronaut.title)
      end

      within '#standard-reviews' do
        click_link(astronaut.reviews[0].user.username)
      end

      click_link("Newest to Oldest")

      within '#all-reviews' do
        expect(page.all('li')[0]).to have_content(user_1.reviews.last.headline)
        expect(page.all('li')[1]).to have_content(user_1.reviews.first.headline)
      end
    end

    it "displays a delete review link and then a redirected page without that review" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css = Book.create(title: "Heyyy", pages: 456, year: 2012, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      css.authors << Author.find_or_create_by(name: 'Chad Hadfield')
      user_1 = User.create(username: "Frodulent Pennycash")
      review_1 = user_1.reviews.create(book: astronaut, body: "I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it", headline: 'I have so many good things to say about this book', rating: 5)
      review_2 = user_1.reviews.create(book: css, body: "this is the body of a review", headline: 'this is the headline of a review', rating: 1)

      visit books_path

      within "#books" do
        click_link(astronaut.title)
      end

      within '#standard-reviews' do
        click_link(astronaut.reviews[0].user.username)
      end

      within "#review-#{review_1.id}" do
        click_link("Delete Review")
      end

      expect(page).to have_content(css.reviews[0].headline)
      expect(page).to have_content(css.reviews[0].body)
      expect(page).to have_content(css.reviews[0].book.title)

      expect(page).to_not have_content(astronaut.reviews[0].headline)
      expect(page).to_not have_content(astronaut.reviews[0].body)
      expect(page).to_not have_content(astronaut.reviews[0].book.title)
    end
  end
end
