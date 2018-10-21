# frozen_string_literal: true

require 'trello'

class TrelloTracker
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def refresh_user_information!
    @user.pulling!

    configure_trello_client_for_user
    clear_users_trello_information
    fetch_users_trello_information

    @user.idle!
  end

  private

  def fetch_users_trello_information
    Trello::Board.all.each do |trello_board|
      board = Board.find_or_create_by!(name: trello_board.name, user: @user)
      trello_board.lists.each do |trello_list|
        list = List.find_or_create_by!(name: trello_list.name, board: board)
        trello_list.cards.each do |trello_card|
          Card.find_or_create_by!(name: trello_card.name, list: list)
        end
      end
    end
  end

  def clear_users_trello_information
    boards = Board.where(user: @user)
    lists = boards.map(&:lists).flatten
    cards = boards.map(&:cards).flatten

    cards.map(&:delete)
    lists.map(&:delete)
    boards.delete_all
  end

  def configure_trello_client_for_user
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = @user.trello_token
    end
  end
end
