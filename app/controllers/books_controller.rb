class BooksController < ApplicationController

  def index
    @books = Book.all
    # require 'pry'; binding.pry
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    # require 'pry'; binding.pry
    @book = Book.new
  end

  def create
    # require 'pry'; binding.pry
    @book = Book.create!(book_params)
    @book.save
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :year, :pages, :cover_url, :authors)
  end

end
