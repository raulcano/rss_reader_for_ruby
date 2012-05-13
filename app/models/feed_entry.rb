class FeedEntry < ActiveRecord::Base
  include Feedzirra
  attr_accessible  :name, :summary, :url, :published_at, :guid, :feed_source_id
  belongs_to :feed_source
  
  default_scope order: 'feed_entries.created_at DESC'
  
  def self.update_from_feed(feed_url, feed_source_id = nil)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, feed_source_id)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes, feed_source_id = nil)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries,feed_source_id)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries,feed_source_id) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries,feed_source_id = nil)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
		  :feed_source_id => feed_source_id
        )
      end
    end
  end
end