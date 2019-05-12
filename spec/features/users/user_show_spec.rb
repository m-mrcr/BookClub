require "rails_helper"

describe "user clicks reviewer on any book review" do
  describe "user is directed to show page for that reviewer" do
    it "displays that reviewers name as a link" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it", headline: 'I have so many good things to say about this book', rating: 5)

      visit books_path
      click_link(astronaut.title)

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
      click_link(astronaut.title)

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
  end
end
