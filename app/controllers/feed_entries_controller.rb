class FeedEntriesController < ApplicationController
 
  def index
  	feed_url = "http://www.elblogsalmon.com/categoria/el-blog-salmon/rss2.xml"
	FeedEntry.update_from_feed(feed_url)
	@feed_entries = FeedEntry.all
  end
  
end
