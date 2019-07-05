class RenameIntervalMinutesToIntervalSeconds < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :interval_minutes, :interval_seconds
  end
end
