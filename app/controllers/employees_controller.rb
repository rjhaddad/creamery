class EmployeesController < ApplicationController
	before_action :set_employee, only: [:show, :edit, :update, :destroy]
  authorize_resource
  has_scope :active
  has_scope :inactive
  has_scope :admins
  has_scope :managers
  has_scope :regulars
  has_scope :alphabetical
  has_scope :younger_than_18
  has_scope :is_18_or_older

  def index
    
    if current_user.role? :manager
      @active_employees = apply_scopes(Employee).for_store(current_user.employee.current_assignment.store_id).active.alphabetical
      @inactive_employees = apply_scopes(Employee).for_store(current_user.employee.current_assignment.store_id).inactive.alphabetical
    elsif 
      @active_employees = apply_scopes(Employee).active.alphabetical
      @inactive_employees = apply_scopes(Employee).inactive.alphabetical
    end
    
    @employees = apply_scopes(Employee).all
    # @employees = Employee.all
    #
    
    # if params[:scope].empty?
    #   @employees = Employee.all
    # else
    #   @employees = Employee.send(params[:scope])
    # end

    # if current_user.role == 'admin'
    #   @employees = Employee.active.alphabetical
      
    # elsif current_user.role == 'manager'
    #   @employees = current_user.employee.current_assignment.store.current_employees
  # end
    # @active_employees = Employee.active.alphabetical.paginate(page: params[:active_employees]).per_page(10)
    # @inactive_employees = Employee.inactive.alphabetical.paginate(page: params[:inactive_employees]).per_page(10)

  end
  
  def new
      @employee = Employee.new
      @employee.build_user


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
    redirect_to employees_url
  end
    
  def edit
      @employee = Employee.find(params[:id])
  end

  def show
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
  	params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :active,  user_attributes: [:id, :email, :password])
  end
    


end
