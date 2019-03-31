class EmployeesController < ApplicationController
	
	before_action :set_employee, only: [:show, :edit, :update, :destroy]
	
    def new
        @employee = Employee.new
    end

	def create
		@employee = Employee.new(params[:employee])
		if @employee.save
			# if saved to database
			redirect_to employee_path(@employee), notice: "Employee #{@employee.proper_name} has been successfully added."
		else
			# return to the 'new' form
			render action: 'new'
		end
	end

	def index
		
	end
	
	def show
		
	end
	
	def edit
		@employee = Employee.find(params[:id])
	end

	def update
		
	end
	
	def destroy
		@employee.destroy
		redirect_to employees_path, notice: "Employee #{@employee.proper_name} has been successfully removed."
	end
	
	
	private
	
	def set_employee
		@employee = Employee.find(params[:id])
	end

	def employee_params
    	params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :role, :phone, :active)
	end
  
end
