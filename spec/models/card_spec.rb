# frozen_string_literal: true

# == Schema Information
#
# Table name: cards
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  list_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stats      :jsonb
#

require 'rails_helper'

RSpec.describe Card, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:list) }

  let (:card) {FactoryBot.create(:card, name: '(5) test [5]')}

  it 'analyses its name for scrum markers and lists their values in its stats hash' do
    expect(card.stats).to eq({'estimated' => '5', 'actual' => '5'})
  end
end
