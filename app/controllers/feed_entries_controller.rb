class FeedEntriesController < ApplicationController
 
  def show
    @feed_entry = FeedEntry.find(params[:id])
  end
  
  def destroy
    @feed_entry.destroy
    #redirect_back_or root_path
  end
  
end
