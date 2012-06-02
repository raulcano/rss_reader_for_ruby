class AddFeedSourceUrlToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :feed_source_url, :string
    add_index  :feed_entries, :feed_source_url
  end
end
