# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all
  include CardRelationDecorations
  include ListRelationDecorations
  include BoardRelationDecorations

  def few_scrum_tracking_markers?
    @few_scrum_tracking_markers ||= boards_with_no_values.count > board_count / 2
  end

  def boards_with_no_values
    @boards_with_no_values ||= boards_with_stats.select { |board| board.stats['estimated'].zero? }
  end
end
