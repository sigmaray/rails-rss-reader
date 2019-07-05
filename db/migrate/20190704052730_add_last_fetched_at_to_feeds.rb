class AddLastFetchedAtToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :last_fetched_at, :datetime
  end
end
