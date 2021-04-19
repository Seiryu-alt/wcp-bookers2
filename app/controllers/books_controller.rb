class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
    unless current_user == @book.user
      flash[:alert] = "Access denied"
      redirect_back fallback_location: books_path
    end
  end

  def create
    book = current_user.books.new(book_params)
    if book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(book)
    else
      @new_book = book
      @books = Book.all
      render :index
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(book)
    else
      @book = book
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "You have destroyed book successfully."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end