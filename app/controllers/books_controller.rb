class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]
  def new
    @book = Book.new
  end

  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
    render :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  def edit
    @book = Book.find(params[:id])
  end
    def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
    render :edit
    end
    end
    private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def ensure_correct_user
    @book = Book.find(params[:id])
     unless @book.user == current_user
     redirect_to books_path
     end
  end
end
