class RenameIntervalToIntervalMinutes < ActiveRecord::Migration[5.2]
  def change
    rename_column :feeds, :interval, :interval_minutes
  end
end
