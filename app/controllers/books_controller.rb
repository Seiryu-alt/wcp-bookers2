class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end

  def create
    book = current_user.books.new(post_book_params)
    book.save
    redirect_to book_path(book)
  end

  def edit
  end

  private
  def post_book_params
    params.require(:book).permit(:title, :body)
  end
end
