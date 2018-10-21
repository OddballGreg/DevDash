# frozen_string_literal: true

module BoardRelationDecorations
  def boards
    @boards ||= super
  end

  def board_count
    @board_count ||= boards.count.to_i
  end

  def estimated_hours_per_board
    @estimated_hours_per_board ||= h.number_with_precision(estimated_board_hours / nonzero_board_count, precision: 2)
  end

  def actual_hours_per_board
    @actual_hours_per_board ||= h.number_with_precision(actual_board_hours / nonzero_board_count, precision: 2)
  end

  def boards_with_stats
    @boards_with_stats ||= boards.select { |board| board.stats }
  end

  def estimated_board_hours
    @estimated_board_hours ||= boards_with_stats.map { |board| board.stats['estimated'].to_i }.sum.to_f
  end

  def actual_board_hours
    @actual_board_hours ||= boards_with_stats.map { |board| board.stats['actual'].to_i }.sum.to_f
  end

  def nonzero_board_count
    @nonzero_board_count ||= board_count.nonzero? || 1
  end
end
