require "rails_helper"

describe "user sees one book" do
  describe "they link from the books index" do
    it "displays information for one book" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      hunger = Book.create(title: 'The Hunger Games', pages: 374, year: 2008, cover_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
      hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      astronaut.authors << Author.find_or_create_by(name: 'James Cape')
      user_2 = User.create(username: "Snorkeldink Crumplehorn")
      user_2.reviews.create(book: astronaut, body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", headline: 'I have so many good things to say about this book', rating: 5)
      user_3 = User.create(username: "Fiddlestick Calldispatch")
      user_3.reviews.create(book: hunger, body: "This is an interesting treatise on food theory and utopian food consumption", headline: "Hungry hungry killers", rating: 3)

      visit books_path

      click_link astronaut.title

      expect(current_path).to eq(book_path(astronaut.id))

      expect(page).to have_content(astronaut.title)
      expect(page).to have_content(astronaut.authors[0].name)
      expect(page).to have_content(astronaut.pages)
      expect(page).to have_content(astronaut.year)

      expect(page).to have_xpath("//img[contains(@src,'#{astronaut.cover_url}')]")
      expect(page).to have_content("Snorkeldink Crumplehorn")
      expect(page).to have_content("I have so many good things")

      expect(page).to_not have_content(hunger.title)
      expect(page).to_not have_content(hunger.pages)
      expect(page).to_not have_content(hunger.year)
      expect(page).to_not have_xpath("//img[contains(@src,'#{hunger.cover_url}')]")
      expect(page).to_not have_content("Fiddlestick Calldispatch")
      expect(page).to_not have_content("This is an interesting treatise")
    end

    it "displays the top three reviews" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')

      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      user_1 = User.create(username: "Snorkeldink Crumplehorn")
      user_2 = User.create(username: "Fiddlestick Calldispatch")
      user_3 = User.create(username: "Burlington Anglerfish")
      user_4 = User.create(username: "Birdbox Bandersnatch")

      user_1.reviews.create(book: astronaut, body: "body 1", headline: 'headline 1', rating: 2)
      user_2.reviews.create(book: astronaut, body: "body 2", headline: "headline 2", rating: 1)
      user_3.reviews.create(book: astronaut, body: "body 3", headline: "headline 3", rating: 4)
      user_4.reviews.create(book: astronaut, body: "body 4", headline: "headline 4", rating: 3)

      visit books_path
      click_link astronaut.title

      within '#top-three-reviews' do
        expect(page).to have_content(user_3.reviews.first.headline)
        expect(page).to have_link(user_3.reviews.first.user.username)
        expect(page).to have_content(user_3.reviews.first.rating)
        expect(page).to have_content(user_4.reviews.first.headline)
        expect(page).to have_content(user_1.reviews.first.headline)

        expect(page).to_not have_content(user_2.reviews.first.headline)
      end

      within '#bottom-three-reviews' do
        expect(page).to have_content(user_2.reviews.first.headline)
        expect(page).to have_link(user_2.reviews.first.user.username)
        expect(page).to have_content(user_2.reviews.first.rating)
        expect(page).to have_content(user_1.reviews.first.headline)
        expect(page).to have_content(user_4.reviews.first.headline)

        expect(page).to_not have_content(user_3.reviews.first.headline)
      end

      within '#average-rating' do
        expect(page).to have_content((1 + 2 + 3 + 4)/4.0)
      end
    end

    it "displays 0 when there are no reviews (edge case)" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')

      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      user_1 = User.create(username: "Snorkeldink Crumplehorn")
      user_2 = User.create(username: "Fiddlestick Calldispatch")
      user_3 = User.create(username: "Burlington Anglerfish")
      user_4 = User.create(username: "Birdbox Bandersnatch")

      visit books_path
      click_link astronaut.title

      within '#average-rating' do
        expect(page).to have_content(0)
      end
    end

    it "displays author name as link" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')

      visit books_path

      click_link(astronaut.title)

      expect(page).to have_link(astronaut.authors[0].name)
    end

    it "display a link to Delete Book" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Fopper")
      user_1.reviews.create(book: astronaut, body: "including my", headline: "Wow", rating: 5)
      user_2.reviews.create(book: astronaut, body: "reaction to it", headline: "Yikes", rating: 4)

      visit books_path
      click_link(astronaut.title)

      expect(page).to have_content("Delete Book")
    end

    it "redirects to Book Index after clicking link" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Fopper")
      user_1.reviews.create(book: astronaut, body: "including my", headline: "Wow", rating: 5)
      user_2.reviews.create(book: astronaut, body: "reaction to it", headline: "Yikes", rating: 4)

      visit books_path
      click_link(astronaut.title)
      click_link("Delete Book")

      expect(current_path).to eq(books_path)
    end

    it "does not display deleted book after clicking link and redirecting" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Fopper")
      user_1.reviews.create(book: astronaut, body: "including my", headline: "Wow", rating: 5)
      user_2.reviews.create(book: astronaut, body: "reaction to it", headline: "Yikes", rating: 4)

      visit books_path
      click_link(astronaut.title)
      click_link("Delete Book")

      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(astronaut.title)
    end
  end
end
