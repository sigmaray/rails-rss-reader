class ChangePubDateInItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :pub_date, :datetime
  end
end
