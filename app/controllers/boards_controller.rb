# frozen_string_literal: true

class BoardsController < ApplicationController
  def index
    @boards = current_user.boards
  end

  def show
    @board = Board.find(params[:id])
  end
end
