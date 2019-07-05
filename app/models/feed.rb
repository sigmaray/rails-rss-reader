class Feed < ApplicationRecord
  has_many :items

  scope :visible, -> { where(should_show: true) }
  scope :fetchable, -> { where(should_fetch: true) }

  validates :url, uniqueness: true, presence: true

  def to_s
    url
  end
end
