class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :find_board
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]
  before_filter :auth_article_writor, :only => [:update, :edit, :destroy]
  
  def index
    @posts = @board.posts.recent.paginate(:page => params[:page], :per_page => 4)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = @board.posts.build(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to board_posts_path
    else
      render :action => "new"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update 
    if @post.update_attributes(params[:post])
      redirect_to board_post_path(@board, @post)
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @post.destroy
    redirect_to board_posts_path
  end
  
  protected
  
  def find_board
    @board = Board.find(params[:board_id])
  end
  
  def find_post
    @post = @board.posts.find(params[:id])
  end
  
  def auth_article_writor
    unless (user_signed_in? && (@post.user == current_user))
      redirect_to board_posts_path
    end
  end
end
