class StoresController < ApplicationController
    before_action :set_store, only: [:show, :edit, :update, :destroy]

  def index
    @stores = Store.active.alphabetical
  end
  
  def new
      @store = Store.new
  end
    
  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to store_path(@store), notice: "Successfully created #{@store.name}."
    else
      render action: 'new'
    end
  end
    
  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:notice] = "Store #{@store.name} has been successfully removed."
    redirect_to stores_url
  end
    
  def edit
      @store = Store.find(params[:id])
  end
    
  def update
		if @store.update(store_params)
			redirect_to store_path(@store), notice: "Successfully updated #{@store.name}."
		else
			render :action => 'edit'
		end
  end
  
  private
  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :latitude, :longitude, :active)
  end
    

end


