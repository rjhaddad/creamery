class ShiftsController < ApplicationController
    
    def index
		@shifts = Shift.chronological
	end
	
	def show
		@shift = Shift.find(params[:id])
	end

	def new
		@shift = Shift.new
	end

	def edit
		@shift = Shift.find(params[:id])
	end

	def create
		@shift = Shift.new(params[:shift])
		if @shift.save
			# if saved to database
			flash[:notice] = "Successfully created this shift."
			redirect_to @shift # go to show shift page
		else
			# return to the 'new' form
			render action: 'new'
		end
	end

	def update
		@shift = Shift.find(params[:id])
		if @shift.update_attributes(params[:shift])
			flash[:notice] = "Successfully updated this shift."
			redirect_to @shift
		else
			render :action => 'edit'
		end
	end

    def destroy
      @shift = Shift.find(params[:id])
      @shift.destroy
      flash[:notice] = "Successfully removed this shift from the system."
      redirect_to shifts_url
    end
end
