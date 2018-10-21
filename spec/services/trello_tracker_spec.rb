# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TrelloTracker do
  let (:user) { FactoryBot.create(:user) }
  let (:subject) { TrelloTracker.new(user.id) }
  let (:config_double) { double.as_null_object }
  let (:card) { double(name: 'test') }
  let (:card_enum) { double }
  let (:list) { double(name: 'test') }
  let (:list_enum)  { double }
  let (:board_enum) { double(name: 'test') }
  let (:board) { double(name: 'test') }

  it 'fetches the users board, list and card information from trello' do
    allow(subject).to receive(:configure_trello_client_for_user)
    allow(subject).to receive(:clear_users_trello_information)
    expect(Trello::Board).to receive(:all).and_return(board_enum)
    expect(board_enum).to receive(:each).and_yield(board)
    expect(board).to receive(:lists).and_return(list_enum)
    expect(list_enum).to receive(:each).and_yield(list)
    expect(list).to receive(:cards).and_return(card_enum)
    expect(card_enum).to receive(:each).and_yield(card)

    subject.refresh_user_information!
  end

  it 'clears the users existing trello information' do
    allow(subject).to receive(:configure_trello_client_for_user)
    allow(subject).to receive(:fetch_users_trello_information)

    board = FactoryBot.create(:board, user: user)
    list = FactoryBot.create(:list, board: board)
    FactoryBot.create(:card, list: list)

    subject.refresh_user_information!
    user.reload
    expect(user.cards.count).to eq 0
    expect(user.lists.count).to eq 0
    expect(user.boards.count).to eq 0
  end

  it 'configures itself to request information from the Trello Api' do
    expect(Trello).to receive(:configure).and_yield(config_double)
    allow(subject).to receive(:clear_users_trello_information)
    allow(subject).to receive(:fetch_users_trello_information)
    subject.refresh_user_information!
  end

  it 'run through the three phases of a trello information refresh' do
    expect(subject).to receive(:configure_trello_client_for_user)
    expect(subject).to receive(:clear_users_trello_information)
    expect(subject).to receive(:fetch_users_trello_information)
    subject.refresh_user_information!
  end
end
