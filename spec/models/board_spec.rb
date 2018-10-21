# frozen_string_literal: true

# == Schema Information
#
# Table name: boards
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stats      :jsonb
#  user_id    :bigint(8)
#

require 'rails_helper'

RSpec.describe Board, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:lists) }
  it { is_expected.to have_many(:cards) }

  let! (:board) {FactoryBot.create(:board, name: 'DevOps')}

  it 'analyses its children for scrum marker statss and sumarizes their values in its own stats hash' do
    list = FactoryBot.create(:list, stats: {estimated: 5, actual: 5}, board: board)
    FactoryBot.create(:card, name: '(5) test [5]', list: list)
    board.reload
    expect(board.stats).to eq({'estimated' => 5, 'actual' => 5})
  end
end
