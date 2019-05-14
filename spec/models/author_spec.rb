require "rails_helper"

RSpec.describe Author, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "relationships" do
    it { should have_many :author_books}
    it { should have_many(:books).through(:author_books)}
  end

  describe "helper methods" do
    it "can find co-authors" do
      astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", pages: 884, year: 2013, cover_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      astronaut.authors << Author.find_or_create_by(name: 'Martin Mercer')

      expect(Author.alternate_authors(astronaut.authors[0])).to eq([astronaut.authors[1]])
    end
  end

end
