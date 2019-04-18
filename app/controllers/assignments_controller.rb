class AssignmentsController < ApplicationController
  
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  #authorize_resource
    
  def index
    @assignments = Assignment.all
  end
  
    def new
    @assignment = Assignment.new
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
    
 private
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:employee_id, :store_id, :start_date, :end_date, :pay_level)
  end	
  
end
