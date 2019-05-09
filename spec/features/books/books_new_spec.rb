require "rails_helper"

describe "user inputs new book" do
  describe "they link to new from the books index" do
    it "displays a form to enter a new book" do
      island = Book.create(title: "Island", pages: 313, year: 2018, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')


      visit "/books/new"

      # fill_in "book[title]", with:
      # fill_in "book[year]", with: 1980
      fill_in "book[pages]", with: 450
      fill_in "book[cover_url]", with: new_book
      fill_in "book[authors]", with: new_book

      click_on "Submit Book"

      expect(page).to have_content(new_book)
    end
  end
end
