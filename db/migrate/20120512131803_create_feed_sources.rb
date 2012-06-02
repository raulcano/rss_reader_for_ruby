class CreateFeedSources < ActiveRecord::Migration
  def change
    create_table :feed_sources do |t|
      t.string :title
      t.string :url
      t.string :hashtags
      t.integer :folder_id
      t.integer :user_id

      t.timestamps
    end
  end
end
