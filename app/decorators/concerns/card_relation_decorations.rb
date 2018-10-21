# frozen_string_literal: true

module CardRelationDecorations
  def cards
    @cards ||= super
  end

  def card_count
    @card_count ||= cards.count.to_i
  end

  def estimated_hours_per_card
    @estimated_hours_per_card ||= h.number_with_precision(estimated_card_hours / nonzero_card_count, precision: 2)
  end

  def actual_hours_per_card
    @actual_hours_per_card ||= h.number_with_precision(actual_card_hours / nonzero_card_count, precision: 2)
  end

  def estimated_card_hours
    @estimated_card_hours ||= cards_with_stats.map { |card| card.stats['estimated'].to_i }.sum.to_f
  end

  def actual_card_hours
    @actual_card_hours ||= cards_with_stats.map { |card| card.stats['actual'].to_i }.sum.to_f
  end

  def cards_with_stats
    @cards_with_stats ||= cards.select { |card| card.stats }
  end

  def nonzero_card_count
    @nonzero_card_count ||= card_count.nonzero? || 1
  end

  def cards_in_progress
    @cards_in_progress ||= cards.includes(:lists).where('lists.name ILIKE ?', 'In Progress').count
  end

  def cards_in_code_review
    @cards_in_code_review ||= cards.includes(:lists).where('lists.name ILIKE ?', 'Code Review').count
  end

  def cards_completed_this_sprint
    @cards_completed_this_sprint ||= cards.includes(:lists).where('lists.name ILIKE ?', 'Completed This Sprint').count
  end
end
