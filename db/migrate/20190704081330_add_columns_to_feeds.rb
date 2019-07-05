class AddColumnsToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :should_fetch, :boolean, default: true
    add_column :feeds, :should_show, :boolean, default: true
  end
end
