class TrelloTracker
  def self.refresh!(user_id)
    User.find(user_id).pulling!

    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_API_KEY']
      config.member_token = User.find(user_id).trello_token
    end

    boards = Board.where(user_id: user_id)
    boards.map(&:cards).flatten.map(&:delete)
    boards.map(&:lists).flatten.map(&:delete)
    boards.delete_all

    Trello::Board.all.each do |trello_board|
      board = Board.find_or_create_by!(name: trello_board.name, user_id: user_id)
      trello_board.lists.each do |trello_list|
        list = List.find_or_create_by!(name: trello_list.name, board: board)
        trello_list.cards.each do |trello_card|
          card = Card.find_or_create_by!(name: trello_card.name, list: list)
          card.set_metrics!
        end
        list.set_metrics!
      end
      board.set_metrics!
    end

    User.find(user_id).idle!
  end
end