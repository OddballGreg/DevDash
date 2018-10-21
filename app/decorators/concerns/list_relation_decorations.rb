# frozen_string_literal: true

module ListRelationDecorations
  def lists
    @lists ||= super
  end

  def list_count
    @list_count ||= lists.count.to_i
  end

  def estimated_hours_per_list
    @estimated_hours_per_list ||= h.number_with_precision(estimated_list_hours / nonzero_list_count, precision: 2)
  end

  def actual_hours_per_list
    @actual_hours_per_list ||= h.number_with_precision(actual_list_hours / nonzero_list_count, precision: 2)
  end

  def actual_list_hours
    lists_with_stats.map { |list| list.stats['actual'].to_i }.sum.to_f
  end

  def estimated_list_hours
    lists_with_stats.map { |list| list.stats['estimated'].to_i }.sum.to_f
  end

  def lists_with_stats
    @lists_with_stats ||= lists.reject { |list| list.stats.nil? }
  end

  def nonzero_list_count
    @nonzero_list_count ||= list_count.nonzero? || 1
  end
end
