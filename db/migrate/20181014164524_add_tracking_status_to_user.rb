class AddTrackingStatusToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tracking_status, :integer, required: true, default: 0
  end
end
