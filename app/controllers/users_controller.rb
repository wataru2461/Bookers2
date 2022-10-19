class UsersController < ApplicationController
  before_action :baria_user, only:[:edit, :update]


  def new

  end

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'successfully'
      redirect_to user_path
    else
      @user = User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end
end
