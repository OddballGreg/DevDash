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
  validates :name, presence: true

  belongs_to :user
  has_many :lists
  has_many :cards, through: :lists

  def set_metrics!
    self.stats = { estimated: 0, actual: 0 }
    valid_lists = lists.reject { |list| list.stats.nil? }
    stats[:estimated] = valid_lists.map { |list| list.stats['estimated'].to_i }.sum
    stats[:actual] = valid_lists.map { |list| list.stats['actual'].to_i }.sum
    save!
  end
end
