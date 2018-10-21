# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListDecorator do
  let! (:user) { FactoryBot.create(:user) }
  let! (:board) { FactoryBot.create(:board, user: user) }
  let! (:list) { FactoryBot.create(:list, board: board) }
  let! (:card) { FactoryBot.create(:card, list: list) }
  let (:subject) { list.decorate }

  it 'should allow the users relations to be retrieved' do
    expect(subject.cards).to eq(user.cards)
  end

  it 'should allow the users relation counts to be retrieved' do
    expect(subject.card_count).to eq(user.cards.count)
  end

  it 'should allow the users relation average estimated hours to be retrieved' do
    expect(subject.estimated_hours_per_card).to match(/^\d+\.\d+$/)
  end

  it 'should allow the users relation average actual hours to be retrieved' do
    expect(subject.actual_hours_per_card).to match(/^\d+\.\d+$/)
  end
end
