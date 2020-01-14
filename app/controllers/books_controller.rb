class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:book_created] = "You have creatad book successfully."
      redirect_to book_path(@book)
      # @必要 => redirect_toつまりviewに変数を渡す必要がある。
    else
      @user = current_user
      @new_book = Book.new
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    # createメソッドの Book.new と同じ変数名にする。
    #   =><div class="error"> 本来 createメソッド実行時、@bookにエラーが無いか読み取るもの。
    #     対して indexメソッド踏んだ時(createメソッド実行前)は indexメソッドの @bookを探すため。
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:book_updated]
      redirect_to book_path(@book)
    else
      @book = Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:book_destroyed] = "You have destroyed book successfully."
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    book = Book.find(params[:id])
    user = book.user
    if current_user.id != user.id
      redirect_to books_path
    end
  end

end
