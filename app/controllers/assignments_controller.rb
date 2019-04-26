class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  #using has_scope gem for ease in filtering data in views
  has_scope :current
  has_scope :past
  has_scope :by_store
  has_scope :by_employee  
  has_scope :chronological
  has_scope :for_store
  has_scope :for_employee
  has_scope :for_pay_level
  has_scope :for_role
  
  
  def index
    @assignments = apply_scopes(Assignment).all
    @employees = Employee.all
    @current_assignments =  apply_scopes(Assignment).current.by_store.by_employee.chronological #.paginate(page: params[:current_assignments]).per_page(15)
    @past_assignments =  apply_scopes(Assignment).past.by_employee.by_store #.paginate(page: params[:past_assignments]).per_page(15)  
  end
  
  def show
    @store = current_user.employee.current_assignment.store
    @employee = @assignment.employee
    @upcoming_shifts = @assignment.shifts.upcoming.chronological.paginate(page: params[:upcoming_shifts]).per_page(5)
    @past_shifts = @assignment.shifts.past.chronological.paginate(page: params[:past_shifts]).per_page(5)

  end
  
    def new
    @assignment = Assignment.new
    if logged_in? and !current_user.role? :admin
      @this_assignment = Assignment.by_store(current_user.employee.stores)
    end
		# @assignment.store_id = params[:store_id] unless params[:store_id].nil?
		# @assignment.employee_id = params[:employee_id] unless params[:employee_id].nil?
    end 

    def create
    @assignment = Assignment.new(assignment_params)
    
    if @assignment.save
      redirect_to assignments_path, notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
      # redirect_to assignment_path(@assignment), notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
    else
      render action: 'new'
    end
    end
  
    def destroy
        @assignment = Assignment.find(params[:id])
        @assignment.destroy
        flash[:notice] = "Assignment #{@assignment.employee.proper_name} successfully removed"
        redirect_to assignments_url
    end
  def update
    if @assignment.update(assignment_params)
      redirect_to assignments_path, notice: "#{@assignment.employee.proper_name}'s assignment to #{@assignment.store.name} is updated."
    else
      render action: 'edit'
    end
  end  
 private
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:employee_id, :store_id, :start_date, :end_date, :pay_level)
  end	
  
end
