class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    author = Author.find_or_create_by(name: params[:book][:authors])
    book = Book.new(book_params)
    book.cover_url = "https://unmpress.com/sites/default/files/default_images/no_image_book.jpg" if book.cover_url.empty?
    book.authors << author
    book.save
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :year, :pages, :cover_url)
  end

end
