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

class List < ApplicationRecord
  belongs_to :board
  has_many :cards

  validates :name, presence: true

  def set_metrics!
    self.stats = { estimation: 0, actual: 0 }
    valid_cards = cards.reject { |card| card.stats.nil? }
    stats[:estimation] = valid_cards.map { |card| card.stats.dig('estimation').to_i }.sum
    stats[:actual] = valid_cards.map { |card| card.stats.dig('actual').to_i }.sum
    save!
  end
end
