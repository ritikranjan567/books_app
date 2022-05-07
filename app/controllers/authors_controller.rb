class AuthorsController < ApplicationController

  before_action :check_authority
  before_action :get_author, only: [:destroy]

  # GET /authors
  def index
    @authors = Author.all
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  #POST /authors
  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path, notice: "New author successfully created"
    else
      render "new"
    end
  end

  #DELETE /authors/:id
  def destroy
    @author.destroy
    redirect_to authors_path
  end

  private

  def author_params
    params.require(:author).permit(:name, :description)
  end

  def get_author
    @author = Author.find(params[:id])
  end
end
