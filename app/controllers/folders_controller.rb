class FoldersController < ApplicationController
  include TheSortableTreeController::Rebuild
  
  
  def new
	@folder = Folder.new
  end
  
  def create
    @folder = Folder.new(params[:folder])
	if @folder.save
		  # Handle a successful save.
		  flash[:success] = "Folder created"
		  redirect_to @folder
		else
		  render 'new'
	end
  end
  
  def manage
    @folders = Folder.nested_set.all
  end
  
end
