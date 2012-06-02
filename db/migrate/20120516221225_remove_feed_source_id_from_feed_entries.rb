class RemoveFeedSourceIdFromFeedEntries < ActiveRecord::Migration
  def change
    remove_column :feed_entries, :feed_source_id
  end
end
