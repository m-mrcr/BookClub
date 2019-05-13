class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])

    # It is ok to just say @author.books in the view and not condense this
    @books = @author.books
    @alternate_authors = []

    # Make ActiveRecord - where.not
    @books.each do |book|
      book.authors.each do |author|
        unless @author.name == author.name
          @alternate_authors << author
        end
      end
    end
  end


  def destroy
    @author = Author.find(params[:id])

    # Ask instructor? Make ActiveRecord (?)
    @author.books.each do |book|
      book.authors.each do |book_author|
        if book_author.books.count == 1
          book_author.destroy
        end
      end
      book.destroy
    end
    redirect_to books_path
  end

end
