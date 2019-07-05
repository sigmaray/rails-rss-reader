class Item < ApplicationRecord
  PER_PAGE = 10

  belongs_to :feed

  scope :visible, -> { joins(:feed).where('feeds.should_show' => true)  }
end
