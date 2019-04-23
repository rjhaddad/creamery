class HomeController < ApplicationController
  before_action :set_stores, only: [:show, :edit, :update, :destroy]
  def guest
    puts "**********"
    @stores = Store.active.alphabetical;
    @employees = Employee.active.alphabetical;
    puts @stores
    puts @employees
  end
  def index
    puts "**********"
    @stores = Store.active.alphabetical;
    @employees = Employee.active.alphabetical;
    puts @stores
    puts @employees

  end

  def home
    @active_stores = Store.active
    @active_flavors = Flavor.active
    @active_employees = Employee.active
  end
  
  

  def about
  end

  def privacy
  end

  def contact
  end

  def dashboard
    #unless current_user.employee.role? :admin
      @employee = current_user.employee
    	#@store =  Assignment.current.for_employee(current_user.employee_id).first.store
     @store_flavors = Store.all #@store.store_flavors
      @today_shifts = Shift.for_store(@store).for_next_days(0).chronological
      @assignments = Assignment.current.for_store(@store).by_employee
    #end
  end

  def manage_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store 
    @today_shifts = Shift.for_store(@store).for_next_days(0).chronological #.paginate(page: params[:today_shifts]).per_page(5)
  end

  def employee_home
    @employee = current_user.employee
    @today_shifts = Shift.for_employee(@employee).for_next_days(0) 
  end

  def admin_home
    @employee = current_user.employee
    @active_stores = Store.active.alphabetical #.paginate(page: params[:active_stores]).per_page(5)
    @active_flavors = Flavor.active.alphabetical #.paginate(page: params[:active_flavors]).per_page(5)
    @active_jobs = Job.active.alphabetical #.paginate(page: params[:active_jobs]).per_page(5)

  end

  def past_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    @past_shifts_c = Shift.for_store(@store).completed.past.chronological #.paginate(page: params[:past_shifts_c]).per_page(5)
    @past_shifts_i = Shift.for_store(@store).incomplete.past.chronological #.paginate(page: params[:past_shifts_i]).per_page(5)
  end

  def future_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    @future_shifts = Shift.for_store(@store).after_today.chronological #.paginate(page: params[:future_shifts]).per_page(5)
  end

  def account
    @employee = current_user.employee
    @current_assgn = current_user.employee.current_assignment
    @assignments = @employee.assignments.chronological #.paginate(page: params[:assignments]).per_page(5) 
  end

  def employee_shifts
    @employee = current_user.employee
    @today_shifts = Shift.for_employee(@employee).for_next_days(0) #.paginate(page: params[:today_shifts]).per_page(5) 
    @upcoming_shifts = Shift.for_employee(@employee).for_next_days(14) #.paginate(page: params[:upcoming_shifts]).per_page(5)
    @past_shifts = Shift.for_employee(@employee).past #.paginate(page: params[:past_shifts]).per_page(5)
  end

  def new_shifts
    if logged_in? and current_user.role? :admin
      @new_shifts = Shift.upcoming.reverse_order
    else
      @new_shifts = Shift.upcoming.for_store(current_user.employee.current_assignment.store).reverse_order
    end
  end


  private
  def set_stores
    @stores = Store.all
  end

  
end
