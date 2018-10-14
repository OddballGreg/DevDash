class AddStatsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :stats, :jsonb
    add_column :lists, :stats, :jsonb
    add_column :cards, :stats, :jsonb
  end
end
