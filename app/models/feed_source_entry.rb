class FeedSourceEntry < ActiveRecord::Base
  attr_accessible :feed_entry_id, :is_read, :is_starred

  belongs_to :feed_source
  belongs_to :feed_entry

  validates :feed_source_id, presence: true
  validates :feed_entry_id, presence: true
  validates_uniqueness_of :feed_source_id, scope: :feed_entry_id
end

