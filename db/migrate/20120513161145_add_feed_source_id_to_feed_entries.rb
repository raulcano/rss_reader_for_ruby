class AddFeedSourceIdToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :feed_source_id, :integer
    add_index  :feed_entries, :feed_source_id
  end
end
