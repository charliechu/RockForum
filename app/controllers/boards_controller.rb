class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end
end
