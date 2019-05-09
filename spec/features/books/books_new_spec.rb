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
      expect(current_path).to eq("/books/#{Book.where(title:island_title)[0].id}")
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
      expect(current_path).to eq("/books/#{Book.where(title:island_title)[0].id}")
    end

    it "formats multiple authors" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1990
      island_pages = 234
      island_cover_url = "https://en.wikipedia.org/wiki/File:Island.JPG"
      island_authors = "aLdUs HuXlEy, AlBuS dUmBlEdOrE"

      fill_in "book[title]", with: island_title
      fill_in "book[year]", with: island_year
      fill_in "book[pages]", with: island_pages
      fill_in "book[cover_url]", with: island_cover_url
      fill_in  "book[authors]", with: island_authors
      click_on "Submit Book"

      expect(page).to have_content("Aldus Huxley")
      expect(page).to have_content("Albus Dumbledore")
      expect(current_path).to eq("/books/#{Book.where(title:island_title)[0].id}")
    end

    it "shows default unavailable book" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1990
      island_pages = 234
      island_authors = "aLdUs HuXlEy, AlBuS dUmBlEdOrE"

      fill_in "book[title]", with: island_title
      fill_in "book[year]", with: island_year
      fill_in "book[pages]", with: island_pages
      fill_in  "book[authors]", with: island_authors
      click_on "Submit Book"

      expect(page).to have_xpath("//img[contains(@src,'https://unmpress.com/sites/default/files/default_images/no_image_book.jpg')]")
    end

    it "redirects to home if invalid input" do
      visit books_path
      click_link "New Book"

      expect(current_path).to eq(new_book_path)

      island_title = "Island"
      island_year = 1987
      island_pages = -234
      island_authors = "aLdUs HuXlEy, AlBuS dUmBlEdOrE"

      fill_in "book[title]", with: island_title
      fill_in "book[year]", with: island_year
      fill_in "book[pages]", with: island_pages
      fill_in  "book[authors]", with: island_authors
      click_on "Submit Book"

      expect(current_path).to eq(new_book_path)
    end

  end
end
