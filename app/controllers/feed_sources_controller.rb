class FeedSourcesController < ApplicationController
  
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  def index
	# This code is incomplete
	# We have to show the feed sources belonging to a selected folder
	# So we should capture here the parameter regarding the folder and filter by it
	@feed_sources = current_user.feed_sources
  end
  
  def show
	  # We show the title of the source, a list of its feed entries and a button to refresh
    @feed_source = current_user.feed_sources.find(params[:id])
    
    #This is only for testing the show list
    #@feed_source.update_entries! #this must be removed
    
    
    @feed_entries = @feed_source.feed_entries.paginate(page: params[:page])
  end
  
  def update_entries
    # This, updates the entries of this feed_source and other feed_sources with the same URL
    # There should be another method to update, in which the user presses the "Refresh" button
    # and trigger this action
    @feed_source = current_user.feed_sources.find(params[:id])
    @feed_source.update_entries!
  end
  
  def new
	 @feed_source = current_user.feed_sources.build
  end
  
  def create
    @feed_source = current_user.feed_sources.build(params[:feed_source])
		
    if @feed_source.save
      flash[:success] = "Feed source added!"
	    redirect_to @feed_source
    else
	     render 'new'
    end
	
  end
  
  def edit
	 @feed_source = current_user.feed_sources.find(params[:id])		
  end
  
  def update
    @feed_source = current_user.feed_sources.find(params[:id])
	if @feed_source.update_attributes(params[:feed_source])
      flash[:success] = "Profile updated"
      redirect_to @feed_source
    else
      render 'edit'
    end
  end
  
  
  def destroy
	   # We should take care not to destroy the feed entries  if other user has this feed source in the db
	  # 1.- Check if there are other feed_sources in the db with the same feed_url
	  
	  # 2.- If not, 
	  
	  # Destroy the feed_source_entries (in the relationship)
	  # Destroy the feed_entries belonging to the feed_source
	  # => feed_source.feed_entries.destroy
	  
	  # Destroy the feed_source
	  # 
    
    current_user.feed_sources.find(params[:id]).destroy
    flash[:success] = "Feed source destroyed."
    redirect_to feed_sources_path
  end
  
  
  private

    def correct_user
      @feed_source = current_user.feed_sources.find_by_id(params[:id])
      redirect_to feed_sources_path if @feed_source.nil?
    end  
end
