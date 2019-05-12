require 'rails_helper'

describe "user sees one author" do
  describe "they link from the books index" do
    it "displays information for one author" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      css = Book.create(title: 'CSSucks', pages: 420, year: 2019, cover_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
      css.authors << Author.find_or_create_by(name: 'Matt Weiss')

      visit books_path

      click_link(astronaut.authors[0].name)
      expect(page).to have_content(astronaut.title)
      expect(page).to have_content(astronaut.pages)
      expect(page).to have_content(astronaut.year)
      expect(page).to have_xpath("//img[contains(@src,'#{astronaut.cover_url}')]")

      expect(page).to_not have_content(css.title)
      expect(page).to_not have_content(css.pages)
      expect(page).to_not have_content(css.year)
      expect(page).to_not have_xpath("//img[contains(@src,'#{css.cover_url}')]")
    end

    it "displays information for one author with co-written book" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      astronaut.authors << Author.find_or_create_by(name: 'Matt Weiss')

      visit books_path

      click_link(astronaut.authors[0].name)

      within '#alternate-authors' do
        expect(page).to have_link(astronaut.authors[1].name)
        expect(page).to_not have_link(astronaut.authors[0].name)
      end
    end

    it "displays top review and review info for each book" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 284, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      user_1 = User.create(username: "Flipper")
      user_2 = User.create(username: "Fopper")
      user_1.reviews.create(book: astronaut, body: "including my", headline: "Wow", rating: 5)
      user_2.reviews.create(book: astronaut, body: "reaction to it", headline: "Yikes", rating: 4)

      visit books_path

      click_link(astronaut.authors[0].name)

      expect(page).to have_content(astronaut.reviews[0].headline)
      expect(page).to_not have_content(astronaut.reviews[1].headline)
    end
  end
end
