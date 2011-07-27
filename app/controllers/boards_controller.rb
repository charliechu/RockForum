class BoardsController < ApplicationController
  def index
    @boards = Board.all
    @posts = Post.all
  end
  
  def new
    @board = Board.new
  end
  
  def create
    @board = Board.new(params[:board])
    if @board.save
      redirect_to boards_path
    else
      render :action => "new"
    end
  end
  
  def show 
    @board = Board.find(params[:id])
  end 
  
  def edit 
    @board = Board.find(params[:id])
  end
  
  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(params[:board])
      redirect_to board_path(params[:id])
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @board = Board.find(params[:id])
    @board.posts.destroy_all
    @board.destroy
    redirect_to boards_path
  end
end
