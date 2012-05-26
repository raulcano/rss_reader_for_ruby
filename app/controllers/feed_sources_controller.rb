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
      @feed_source.update_entries!
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
	  @feed_source = current_user.feed_sources.find(params[:id])
    if FeedSource.find_all_by_url(@feed_source.url).count == 1 
      # We assume this will delete both the entries and the relationships
      @feed_source.feed_entries.destroy
    else
      # We assume this will delete only the relationships
      @feed_source.feed_source_entries.destroy
    end
    @feed_source.destroy
    flash[:success] = "Feed source destroyed."
    redirect_to feed_sources_path
  end
  
  
  private

    def correct_user
      @feed_source = current_user.feed_sources.find_by_id(params[:id])
      redirect_to feed_sources_path if @feed_source.nil?
    end  
end