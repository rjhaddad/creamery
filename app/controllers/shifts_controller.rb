class ShiftsController < ApplicationController
    #before_filter :check_login
    before_action :set_shift, only: [:show, :edit, :update, :destroy]
	authorize_resource
	
    def index
    @completed_shifts = Shift.completed.chronological.paginate(page: params[:completed_shifts]).per_page(10)
    @incomplete_shifts = Shift.incomplete.chronological.paginate(page: params[:incomplete_shifts]).per_page(10)  
	end
	
	def show
		@shift = Shift.find(params[:id])
	end

	def new
		@shift = Shift.new
		@shiftadd = Assignment.by_employee
	end

	def edit
		@shift = Shift.find(params[:id])
	end

	def create
		@shift = Shift.new(shift_params)
		if @shift.save
        @assignment = @shift.assignment
			# if saved to database
		@store =  Assignment.current.for_employee(current_user.employee_id).first.store if not current_user.employee.current_assignment.nil?
        @today_shifts = Shift.for_store(@store).for_next_days(0).chronological.paginate(page: params[:today_shifts]).per_page(5)
        @upcoming_shifts = @assignment.shifts.upcoming.chronological.paginate(page: params[:upcoming_shifts]).per_page(5)
        if logged_in? and !current_user.role? :admin
          @new_shifts = Shift.upcoming.for_store(current_user.employee.current_assignment.store).reverse_order
        else
          @new_shifts = Shift.upcoming.reverse_order
        end
			flash[:notice] = "Successfully created this shift."
			redirect_to shifts_path # go to show shift page
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
    
    def set_shift
    @shift = Shift.find(params[:id])
    end
  
    def shift_params
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time)
    end
    
end
