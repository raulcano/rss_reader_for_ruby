class AddIndicesToFeedSources < ActiveRecord::Migration
  def change
	add_index  :feed_sources, [:user_id, :created_at]
  end
end
