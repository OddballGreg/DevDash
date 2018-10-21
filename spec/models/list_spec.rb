# frozen_string_literal: true

# == Schema Information
#
# Table name: lists
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  board_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stats      :jsonb
#

require 'rails_helper'

RSpec.describe List, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:board) }
  it { is_expected.to have_many(:cards) }

  let! (:list) {FactoryBot.create(:list, name: 'in_progress')}

  it 'analyses its children for scrum marker statss and sumarizes their values in its own stats hash' do
    FactoryBot.create(:card, name: '(5) test [5]', list: list)
    list.reload
    expect(list.stats).to eq({'estimated' => 5, 'actual' => 5})
  end
end
