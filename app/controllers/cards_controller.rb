class CardsController < ApplicationController
  def index
    @board = Board.find(params[:board_id])
    @list = List.find(params[:list_id])
    @cards = @list.cards
  end

  def new
    @card = Card.find(params[:id])
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
