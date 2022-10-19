class BooksController < ApplicationController
 before_action :baria_user, only:[:edit, :update]

  def new
   @book = Book.new
  end

  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
    flash[:success] = 'successfully'
    redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render :index
   end
  end

  def index
   @books = Book.all
   @book = Book.new
   @user = current_user
  end

  def show
   @books = Book.all
   @book= Book.find(params[:id])
   @user = current_user
  end

  def edit
   @book = Book.find(params[:id])
   unless @book.user_id = current_user.id
    redirect_to book_path
   end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
   if @book.save
    flash[:success] = 'successfully'
    redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render :edit
   end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
   params.require(:book).permit(:title, :image, :body)
  end
  
  def baria_user
    if current_user.id != Book.find(params[:id]).user_id
      redirect_to books_path
    end
  end
end