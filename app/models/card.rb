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

class Card < ApplicationRecord
  belongs_to :list

  validates :name, presence: true

  after_create :set_metrics!

  private

  def set_metrics!
    self.stats = { estimated: 0, actual: 0 }
    estimated_hours = name.match(/\((\d*\.?\d+)\)/)
    actual_hours = name.match(/\[(\d*\.?\d+)\]/)
    stats[:estimated] = estimated_hours[1] if estimated_hours
    stats[:actual] = actual_hours[1] if actual_hours
    save!
    reload
    list.set_metrics!
  end
end
