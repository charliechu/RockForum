class BoardsController < ApplicationController
  before_filter :find_board, :only => [:show]
  def index
    @boards = Board.all
    @posts = Post.all
  end
  
  def show 

  end 
  
  protected
  
  def find_board
    @board = Board.find(params[:id])
  end
end
