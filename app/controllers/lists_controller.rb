# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @board = Board.find(params[:board_id]).decorate
  end
end
