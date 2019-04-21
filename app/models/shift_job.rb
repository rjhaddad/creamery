class ShiftJob < ApplicationRecord
    
    belongs_to :shift
    belongs_to :job
    
    # validations
    validates_presence_of :shift_id, :job_id
  
end
