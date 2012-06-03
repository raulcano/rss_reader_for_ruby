class FeedSourceEntriesController < ApplicationController
 
  def mark_read
    # this action is executed from the feed_source controller
    # so we have access to the variable feed_source
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    @feed_source_entry.mark_read!
    
    respond_to do |format|
      format.html # no idea what I have to write here
      format.js #mark_read.js.erb within the views folder of the FeedSourceEntries
    end
  end
  
  def mark_unread
    # this action is executed from the feed_source controller
    # so we have access to the variable feed_source
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    @feed_source_entry.mark_unread!
    
    respond_to do |format|
      format.html # no idea what I have to write here
      format.js #mark_read.js.erb within the views folder of the FeedSourceEntries
    end
  end
  
  def fold
    # link to the js that renders the folded element
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    
    respond_to do |format|
      format.html # no idea what I have to write here
      format.js # fold.js.erb within the views folder of the FeedSourceEntries
    end
  end
  
  def unfold
    # mark as read
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    @feed_source_entry.mark_read!
    # link to the js to actually render the html on the unfolded element
    respond_to do |format|
      format.html # ??? no idea what I have to write here
      format.js # unfold.js.erb within the views folder of the FeedSourceEntries
    end
  end
  
  def star
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    @feed_source_entry.star!
    
    respond_to do |format|
      format.html 
      format.js
    end
  end
  
  def unstar
    @feed_source_entry = FeedSourceEntry.find(params[:id])
    @feed_source_entry.unstar!
    
    respond_to do |format|
      format.html 
      format.js
    end
  end
  
end
