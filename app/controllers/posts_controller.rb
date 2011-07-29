class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_board, :only => [:index, :new, :create, :show, :edit, :update, :destroy]
  def index
    @posts = @board.posts.all
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = @board.posts.build(params[:post])
    @post.user_id = current_user.id
    if @post.save
      redirect_to board_posts_path
    else
      render :action => "new"
    end
  end
  
  def show
    @post = @board.posts.find(params[:id])
  end
  
  def edit
    @post = current_user.posts.find(params[:id])
  end
  
  def update 
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to board_posts_path
  end
  
  protected
  def find_board
    @board = Board.find(params[:board_id])
  end
end
