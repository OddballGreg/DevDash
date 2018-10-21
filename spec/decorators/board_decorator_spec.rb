# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoardDecorator do
  let! (:user) { FactoryBot.create(:user) }
  let! (:board) { FactoryBot.create(:board, user: user) }
  let! (:list) { FactoryBot.create(:list, board: board) }
  let! (:card) { FactoryBot.create(:card, list: list) }
  let (:subject) { board.decorate }

  it 'should allow the users relations to be retrieved' do
    expect(subject.lists).to eq(board.lists)
    expect(subject.cards).to eq(board.cards)
  end

  it 'should allow the boards relation counts to be retrieved' do
    expect(subject.list_count).to eq(board.lists.count)
    expect(subject.card_count).to eq(board.cards.count)
  end

  it 'should allow the boards relation average estimated hours to be retrieved' do
    expect(subject.estimated_hours_per_card).to match(/^\d+\.\d+$/)
    expect(subject.estimated_hours_per_list).to match(/^\d+\.\d+$/)
  end

  it 'should allow the boards relation average actual hours to be retrieved' do
    expect(subject.actual_hours_per_card).to match(/^\d+\.\d+$/)
    expect(subject.actual_hours_per_list).to match(/^\d+\.\d+$/)
  end

  it 'should allow the boards cards in specific scrum states to be retrieved' do
    expect(subject.cards_in_progress.class).to eq(Integer)
    expect(subject.cards_in_code_review.class).to eq(Integer)
    expect(subject.cards_completed_this_sprint.class).to eq(Integer)
  end
end
