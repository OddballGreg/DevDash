# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @boards = current_user.boards
    @lists = current_user.lists
    @cards = current_user.cards
  end

  def trigger_refresh
    if current_user.trello_token
      TrelloTrackingJob.perform_later(current_user.id)
      redirect_to root_path, notice: 'Refreshing!'
    else
      redirect_to root_path, alert: 'Cannot refresh without valid user token!'
    end
  end

  def save_trello_token
    current_user.update(trello_token: params[:trello_token])
    redirect_to root_path, notice: 'Trello Token Saved!'
  end
end
