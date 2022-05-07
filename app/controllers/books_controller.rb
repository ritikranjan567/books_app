class BooksController < ApplicationController
  
  before_action :check_authority, except: [:index, :add_to_fav, :remove_from_fav]
  before_action :get_book, only: [:add_to_fav, :destroy, :remove_from_fav]

  #GET /books
  def index
    @books = Book.includes(:authors).order(:created_at)
  end

  #GET /books/new
  def new
    @book = Book.new
    @authors = Author.all
    @categories = Category.all
  end

  #POST /books
  def create
    @book = Book.new(books_params)
    @authors = Author.all
    @categories = Category.all
    @book.category_id = params[:book][:category]
    if @book.save
      @book.authors = @authors.where(id: params[:book][:authors].select {|a| !a.blank? }) if params[:book][:authors]
      redirect_to books_path, notice: "New book created"
    else
      render 'new'
    end
  end

  #DELETE /books/:id
  def destroy
    @book.destroy
    redirect_to books_path
  end

  #POST /books/:id/add_to_fav
  def add_to_fav
    user_id = current_user.id
    if Favorite.where(book_id: @book.id, user_id: user_id).present?
      return redirect_to books_path, notice: "Book is already in you favorites"
    else
      Favorite.create(book_id: @book.id, user_id: user_id)
      redirect_to books_path, notice: "Book is added to the favorites"
    end
  end

  #delete /books/:id/remove_from_fav
  def remove_from_fav
    @favorite = Favorite.find_by(book_id: @book.id, user_id: current_user.id)
    @favorite&.destroy
    redirect_to "/user_favorites", notice: "#{@book.name} removed from favorites"
  end

  #get /book_reports
  def book_reports
    @reports = Favorite.joins(:book).select("count(favorites.user_id) as users, books.name as book_name").group("favorites.book_id").order("users desc")
  end


  private

  def books_params
    params.require(:book).permit(:name, :description)
  end
  
  def get_book
    @book = Book.find params[:id]
  end
end
