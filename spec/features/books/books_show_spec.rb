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
  end
end
