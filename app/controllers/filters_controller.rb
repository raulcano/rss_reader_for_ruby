class FiltersController < ApplicationController
  
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  
  def index
    @filters = current_user.filters
  end
  
  def show
    @filter = current_user.filters.find(params[:id])
  end
  
  def new
   @filter = current_user.filters.build
  end
  
  def create
    @filter = current_user.filters.build(params[:filter])
    if @filter.save
      flash[:success] = "Filter added!"
      redirect_to filters_path
    else
       render 'new'
    end
  
  end
  
  def edit
   @filter = current_user.filters.find(params[:id])   
  end
  
  def update
    @filter = current_user.filters.find(params[:id])
    if @filter.update_attributes(params[:filter])
      flash[:success] = "Filter updated"
      redirect_to filters_path
    else
      render 'edit'
    end
  end
  
  
  def destroy
    @filter = current_user.filters.find(params[:id])
    @filter.destroy
    flash[:success] = "Filter destroyed."
    redirect_to filters_path
  end
  
  
  private

    def correct_user
      @filter = current_user.filters.find_by_id(params[:id])
      redirect_to filters_path if @filter.nil?
    end  
end

