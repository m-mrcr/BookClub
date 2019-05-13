class BooksController < ApplicationController

  def index
    @books = Book.all
    @three_best = Book.three_best_books
    @three_worst = Book.three_worst_books
    @three_top_users = User.most_prolific

    case params[:filter]
    when "rating_best_to_worst"
      @books = Book.sort_avg_rating_best_to_worst
    when "rating_worst_to_best"
      @books = Book.sort_avg_rating_worst_to_best
    when "number_pages_most_to_least"
      @books = Book.sort_number_pages_most_to_least
    when "number_pages_least_to_most"
      @books = Book.sort_number_pages_least_to_most
    when "number_reviews_most_to_least"
      @books = Book.sort_number_reviews_most_to_least
    when "number_reviews_least_to_most"
      @books = Book.sort_number_reviews_least_to_most
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @three_best_reviews = @book.reviews.order(:rating).reverse_order.limit(3)
    @three_worst_reviews = @book.reviews.order(:rating).limit(3)
    if @book.reviews.average(:rating) == nil
      @overall_average = 0
    else
      @overall_average = @book.reviews.average(:rating)
    end
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
