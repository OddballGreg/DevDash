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

class Board < ApplicationRecord
  belongs_to :user
  has_many :lists
  has_many :cards, through: :lists

  def set_metrics!
    self.stats = { estimation: 0, actual: 0 }
    valid_lists = lists.reject { |list| list.stats.nil? }
    stats[:estimation] = valid_lists.map { |list| list.stats.dig('estimation').to_i }.sum
    stats[:actual] = valid_lists.map { |list| list.stats.dig('actual').to_i }.sum
    save!
  end
end
