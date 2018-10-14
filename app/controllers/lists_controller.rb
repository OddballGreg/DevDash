class ListsController < ApplicationController
  def index
    @board = Board.find(params[:board_id])
    @lists = @board.lists
  end

  def new
    @list = List.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
