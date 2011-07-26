class PostsController < ApplicationController
  def index
    @board = Board.find(params[:board_id])
    @posts = @board.posts.all
  end
  
  def new
    @board = Board.find(params[:board_id])
    @post = @board.posts.new
  end
  
  def create
    @board = Board.find(params[:board_id])
    @post = @board.posts.build(params[:post])
    if @post.save
      redirect_to board_posts_path
    else
      render :action => "new"
    end
  end
  
  def show
    @board = Board.find(params[:board_id])
    @post = @board.posts.find(params[:id])
  end
  
  def edit
    @board = Board.find(params[:board_id])
    @post = @board.posts.find(params[:id])
  end
  
  def update 
    @board = Board.find(params[:board_id])
    @post = @board.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @board = Board.find(params[:board_id])
    @post = @board.posts.find(params[:id])
    @post.destroy
    redirect_to board_posts_path
  end
end
