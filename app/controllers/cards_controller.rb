# frozen_string_literal: true

class CardsController < ApplicationController
  def index
    @board = Board.find(params[:board_id])
    @list = List.find(params[:list_id])
    @cards = @list.cards
  end

  def show
    @card = Card.find(params[:id])
  end
end
