class FeedEntry < ActiveRecord::Base
  include Feedzirra
  attr_accessible  :name, :summary, :url, :published_at, :guid, :feed_source_url
  belongs_to :feed_source
  
  default_scope order: 'feed_entries.published_at DESC'
  
  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries,feed_url)
  end
  
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries,feed_url)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      add_entries(feed.new_entries,feed_url) if feed.updated?
    end
  end
  
  private
  
  def self.add_entries(entries, feed_url)
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name            => entry.title,
          :summary         => entry.summary,
          :url             => entry.url,
          :published_at    => entry.published,
          :guid            => entry.id,
          :feed_source_url => feed_url
        )
      end
    end
  end
end