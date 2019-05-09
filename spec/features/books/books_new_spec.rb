require "rails_helper"

describe "user inputs new book" do
  describe "they link to new from the books index" do
    it "displays a form to enter a new book" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1990
      island_pages = 234
      island_cover_url = "https://en.wikipedia.org/wiki/File:Island.JPG"
      island_authors = "Aldus Huxley"

      # island = Book.create(title: "Island", pages: 313, year: 2018, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      # island.authors << Author.create(name: 'Aldus Huxley')

      fill_in "book[title]", with: island_title
      fill_in "book[year]", with: island_year
      fill_in "book[pages]", with: island_pages
      fill_in "book[cover_url]", with: island_cover_url
      fill_in  "book[authors]", with: island_authors
      click_on "Submit Book"

      expect(page).to have_content(island_title)
      expect(current_path).to eq(books_path)
    end
  end
end
