class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.text :url
      t.integer :interval

      t.timestamps
    end
  end
end
