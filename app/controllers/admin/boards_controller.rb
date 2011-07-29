class Admin::BoardsController < ApplicationController
  layout "admin"
  before_filter :find_board, :only => [:show, :edit, :update, :destroy]

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

  end 
  
  def edit 

  end
  
  def update
    if @board.update_attributes(params[:board])
      redirect_to board_path(params[:id])
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @board.posts.destroy_all
    @board.destroy
    redirect_to boards_path
  end
  
  protected
  
  def find_board
    @board = Board.find(params[:id])
  end
end
