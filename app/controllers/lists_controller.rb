# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @board = Board.find(params[:board_id])
    @lists = @board.lists
  end

  def show
    @list = List.find(params[:id])
  end
end
