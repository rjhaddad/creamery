class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.active.alphabetical
  end
  
  def new
      @employee = Employee.new
  end
    
  def create
    @employee= Employee.new(employee_params)
    if @employee.save
      redirect_to employee_path(@employee), notice: "Successfully created #{@employee.first_name}."
    else
      render action: 'new'
    end
  end
    
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    flash[:notice] = "Employee #{@employee.first_name} has been successfully removed."
    redirect_to stores_url
  end
    
  def edit
      @employee = Employee.find(params[:id])
  end
    
  def update
		if @employee.update(employee_params)
			redirect_to employee_path(@employee), notice: "Successfully updated #{@employee.first_name}."
		else
			render :action => 'edit'
		end
  end
  
  private
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
  	params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active)
  end
    

end
