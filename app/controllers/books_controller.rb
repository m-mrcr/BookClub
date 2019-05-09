class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    # @book[:cover_url] = "https://unmpress.com/sites/default/files/default_images/no_image_book.jpg" ? cover_url.empty? : cover_url
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    title = params[:book][:title].titleize
    if Book.titles.include?(title) || params[:book][:pages].to_i < 0
      redirect_to new_book_path
    else
      params[:book][:authors].split(",").each do |author|
        name = author.downcase.strip.titleize
        book_author = Author.find_or_create_by!(name: name)
        book.authors << book_author
      end
      cover_url = params[:book][:cover_url]
      if cover_url.empty?
        book.cover_url = "https://unmpress.com/sites/default/files/default_images/no_image_book.jpg"
      else
        book.cover_url = cover_url
      end

      book.save
      redirect_to book_path(book)
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :year, :pages)
  end

end
