# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  let! (:user) { FactoryBot.create(:user) }
  let! (:board) { FactoryBot.create(:board, user: user) }
  let! (:list) { FactoryBot.create(:list, board: board) }
  let! (:card) { FactoryBot.create(:card, list: list) }
  let (:subject) { user.decorate }

  it 'should allow the users relations to be retrieved' do
    expect(subject.boards).to eq(user.boards)
    expect(subject.lists).to eq(user.lists)
    expect(subject.cards).to eq(user.cards)
  end

  it 'should allow the users relation counts to be retrieved' do
    expect(subject.board_count).to eq(user.boards.count)
    expect(subject.list_count).to eq(user.lists.count)
    expect(subject.card_count).to eq(user.cards.count)
  end

  it 'should allow the users relation average estimated hours to be retrieved' do
    expect(subject.estimated_hours_per_card).to match(/^\d+\.\d+$/)
    expect(subject.estimated_hours_per_list).to match(/^\d+\.\d+$/)
    expect(subject.estimated_hours_per_board).to match(/^\d+\.\d+$/)
  end

  it 'should allow the users relation average actual hours to be retrieved' do
    expect(subject.actual_hours_per_card).to match(/^\d+\.\d+$/)
    expect(subject.actual_hours_per_list).to match(/^\d+\.\d+$/)
    expect(subject.actual_hours_per_board).to match(/^\d+\.\d+$/)
  end

  it 'should allow the users cards in specific scrum states to be retrieved' do
    expect(subject.cards_in_progress.class).to eq(Integer)
    expect(subject.cards_in_code_review.class).to eq(Integer)
    expect(subject.cards_completed_this_sprint.class).to eq(Integer)
  end

  it 'can determine if the user uses the scrum for trello plugin much' do
    expect(subject.few_scrum_tracking_markers?).to be_in([true, false])
  end
end
