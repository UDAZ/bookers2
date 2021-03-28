class UsersController < ApplicationController
before_action :ensure_correct_user, only:[:edit]
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice: "You have updated user successfully."
    else
    render :edit
    end
  end
  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
    def ensure_correct_user
    @user = User.find(params[:id])
     unless @user.id == current_user
     redirect_to user_path(current_user.id)
     end
    end
end