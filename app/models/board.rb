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
    self.stats = {}
    self.stats[:estimation] = lists.map{|list| list.stats['estimation'].to_i rescue 0}.sum
    self.stats[:actual] = lists.map{|list| list.stats['actual'].to_i rescue 0}.sum
    self.save!
  end
end
