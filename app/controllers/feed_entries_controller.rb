class FeedEntriesController < ApplicationController
 
  def destroy
    @feed_entry.destroy
    #redirect_back_or root_path
  end
  
end
