require "rails_helper"

describe "user inputs new book" do
  describe "they link to new from the books index" do
    it "displays a form to enter a new book for one author" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1990
      island_pages = 234
      island_cover_url = "https://en.wikipedia.org/wiki/File:Island.JPG"
      island_authors = "Aldus Huxley"

      fill_in "book[title]", with: island_title
      fill_in "book[year]", with: island_year
      fill_in "book[pages]", with: island_pages
      fill_in "book[cover_url]", with: island_cover_url
      fill_in  "book[authors]", with: island_authors
      click_on "Submit Book"

      expect(page).to have_content(island_title)
      expect(current_path).to eq(books_path)
    end

    it "displays a form to enter a new book for multiple authors" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1990
      island_pages = 234
      island_cover_url = "https://en.wikipedia.org/wiki/File:Island.JPG"
      island_authors = "Aldus Huxley, Albus Dumbledore"

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
