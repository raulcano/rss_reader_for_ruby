class RemoveHashtagsFromFeedSources < ActiveRecord::Migration
def change
    remove_column :feed_sources, :hashtags
  end
end
