# require needed files

require './test/sets/store_contexts'
require './test/sets/employee_contexts'
require './test/sets/assignment_contexts'
require './test/sets/job_contexts'
require './test/sets/shift_contexts'
require './test/sets/shift_job_contexts'
require './test/sets/flavor_contexts'
require './test/sets/user_contexts'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::StoreContexts
  include Contexts::EmployeeContexts
  include Contexts::AssignmentContexts
  include Contexts::JobContexts
  include Contexts::ShiftContexts
  include Contexts::ShiftJobContexts
  include Contexts::FlavorContexts
  include Contexts::UserContexts

  
 def create_contexts
    create_stores
    create_employees
    create_assignments
    create_jobs
    create_shifts
    create_shift_jobs
    create_flavors
    create_users
    
  end
  
  def remove_contexts
    remove_stores
    remove_employees
    remove_assignments
    remove_jobs
    remove_shifts
    remove_shift_jobs
    remove_flavors
    remove_users
  end
  

end