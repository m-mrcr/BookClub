require 'rails_helper'

describe "user inputs new review" do
  describe "links to new from book show page" do
    it "displays a link on book show page for Write Review" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
      css.authors << Author.find_or_create_by(name: 'Matt Weiss')

      visit books_path

      click_link(astronaut.title)

      expect(page).to have_link("Write Review")
    end

    it "displays a form to enter new review when clicking on link to Write Review" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
      css.authors << Author.find_or_create_by(name: 'Matt Weiss')

      user_1 = User.create(username: "Flipper")
      user_1.reviews.create(book: astronaut, body: "I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it", headline: 'I have so many good things to say about this book', rating: 5)


      visit books_path

      click_link(astronaut.title)
      click_link("Write Review")

      expect(current_path).to eq(new_book_review_path(astronaut.id))

      review_headline = "Some Bubkus Review"
      review_username = "littleKitty9000"
      review_body = "I know nothing about this book, I've never read it."

      fill_in "review[headline]", with: review_headline
      fill_in "username", with: review_username

      page.select '4'
      fill_in "review[body]", with: review_body
      click_on "Submit Review"

      expect(page).to have_content(review_headline)
      expect(current_path).to eq("/books/#{astronaut.id}")
      expect(page).to_not have_content("CSSucks")
      expect(current_path).to_not eq("/books/#{css.id}")

      expect(page).to have_content("Littlekitty9000")
    end

  end
end
