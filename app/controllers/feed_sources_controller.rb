class FeedSourcesController < ApplicationController
  
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def index
	# This code is incomplete
	# We have to show the feed sources belonging to a selected folder
	# So we should capture here the parameter regarding the folder and filter by it
	@feed_sources = FeedSource.all
  end
  
  def show
	# We show the title of the source, a list of its feed entries and a button to refresh
    @feed_source = FeedSource.find(params[:id])
	#Also, this code must be refined to show only the feed sources from the user
	
	# Here we fetch all the feed entries belonging to this feed source and this user
	FeedEntry.update_from_feed(@feed_source.url, @feed_source.id)
	# We have to update the feed_source_id to every feed_entry
	@feed_entries = FeedEntry.find_by_feed_source_id(@feed_source.id)
	
	# This code is wrong because it retrieves every feed 
	#@feed_entries = FeedEntry.all
  end
  
  def new
	@feed_source = FeedSource.new
  end
  
  def create
    #@feed_source = current_user.feed_sources.build(params[:feed_source])
	@feed_source = FeedSource.new(params[:feed_source])
    if @feed_source.save
      flash[:success] = "Feed source added!"
	  redirect_to @feed_source
    else
	  render 'new'
    end
	
  end
  
  def destroy
	# We should take care not to destroy the feed entries  if other user has this feed source in the db
    FeedSource.find(params[:id]).destroy
    flash[:success] = "Feed source destroyed."
    redirect_to feed_sources_path
  end
  
end
