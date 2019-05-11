class AuthorsController < ApplicationController

  def show
    # @all_authors = Author.all.where(book.id=)
    @author = Author.find(params[:id])
    @books = @author.books
    @alternate_authors = []
    @books.each do |book|
      book.authors.each do |author|
        unless @author.name == author.name
          @alternate_authors << author
        end
      end
    end
  end

end
