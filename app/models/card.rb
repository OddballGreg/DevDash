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

  def set_metrics!
    self.stats = {}
    estimation = self.name.match(/\((\d*\.?\d+)\)/)
    self.stats[:estimation] = (estimation[1] rescue 0)
    actual = self.name.match(/\[(\d*\.?\d+)\]/)
    self.stats[:actual] = (actual[1] rescue 0)
    self.save!
  end
end
