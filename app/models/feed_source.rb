class FeedSource < ActiveRecord::Base
  attr_accessible :folder_id, :hashtags, :title, :url
  belongs_to :user
  has_many :feed_source_entries, dependent: :destroy
  has_many :feed_entries, through: :feed_source_entries
  
  validates :title, presence: true, length: { maximum: 50}
  validates :user_id, presence: true
  
  validates :url, presence: true, 
					format: { with: URI::ABS_URI }
  
  default_scope order: 'feed_sources.created_at DESC'
  
  def has_entry?(feed_entry)
       self.feed_source_entries.find_by_feed_entry_id(feed_entry.id)
  end

  def add_entry!(feed_entry)
        self.feed_source_entries.create!(feed_entry_id: feed_entry.id)
  end

  def remove_entry!(feed_entry)
       self.feed_source_entries.find_by_feed_entry_id(feed_entry.id).destroy
  end
  
  def update_entries!
    #1.- Add the new entries to the feed_entries table
    # Here we fetch all the feed entries belonging to this feed source and this user
    new_entries = FeedEntry.update_from_feed(url)
    
    # Here we add the relationships to EVERY feed_source that shares the same url
    # 1.1 We obtain every feed source that matches the url
    matching_sources = FeedSource.find_all_by_url(url)
    # 1.2 For each obtained feed source, we update the feed_source_entries table (the relationships)
    matching_sources.each do |s|
      #update relationships in the source s with the new entries
      new_entries.each do |entry|
        s.add_entry!(FeedEntry.find_by_guid(entry.entry_id))
      end
    end
    # We want that this method return the new entries
    new_entries
  end
end
