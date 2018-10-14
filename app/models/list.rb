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

  def set_metrics!
    self.stats = {}
    self.stats[:estimation] = cards.map{|card| card.stats['estimation'].to_i rescue 0}.sum
    self.stats[:actual] = cards.map{|card| card.stats['actual'].to_i rescue 0}.sum
    self.save!
  end
end
