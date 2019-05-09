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
    # create_author = Author.create(name: book_params[:authors])
    # create_book = Book.create(title: book_params[:title], year: book_params[:year], pages: book_params[:pages], cover_url: book_params[:cover_url], authors: [create_author])
    # require 'pry'; binding.pry

    author = Author.find_or_create_by(name: params[:book][:authors])
    book = Book.new(book_params)
    book.authors << author
    book.save
    # require 'pry'; binding.pry
    redirect_to books_path
  end

  private

  def book_params
    # params.require(:book).permit(:title, :year, :pages, :cover_url, :authors)
    params.require(:book).permit(:title, :year, :pages, :cover_url)
  end

end
