class Shift < ApplicationRecord

  #relationships
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  belongs_to :assignment
  has_one :employee, through: :assignment
  has_one :store, through: :assignment

  # validations
  validates_date :date, on_or_after: lambda { :assignment_starts }, on_or_before_message: "must be on or after the start of the assignment"
  validates_time :start_time
  validates_time :end_time, after: :start_time, allow_blank: true
  validate :assignment_must_be_current
  #validates_numericality_of :assignment_id, :only_integer => true, :greater_than => 0  
  
    #scopes
    scope :completed, -> { joins(:shift_jobs).group(:shift_id) }
    scope :incomplete, -> { joins("LEFT JOIN shift_jobs ON shifts.id = shift_jobs.shift_id").where('shift_jobs.job_id IS NULL') }
    
    scope :for_store, lambda {|store_id| joins(:assignment, :store).where("assignments.store_id = ?", store_id) }
    scope :for_employee, lambda {|employee_id| joins(:assignment, :employee).where("assignments.employee_id = ?", employee_id) }
    
    scope :past, -> { where('date < ?', Date.today) }
    scope :upcoming, -> { where('date >= ?', Date.today) }
    
    scope :after_today, -> { where('date > ?', Date.current) }

    scope :for_next_days, lambda {|x| where('date BETWEEN ? AND ?', Date.today, x.days.from_now.to_date) }
    scope :for_past_days, lambda {|x| where('date BETWEEN ? AND ?', x.days.ago.to_date, 1.day.ago.to_date) }
    #scope :for_next_days_after_today, ->(x) { where('date BETWEEN ? AND ?', 1.day.from_now.to_date, x.days.from_now.to_date) }

    scope :chronological, -> { order(:date, :start_time) }
    
    scope :by_store, ->  { joins(:assignment, :store).order('stores.name') }
	  scope :by_employee, -> { joins(:assignment, :employee).order('employees.last_name, employees.first_name') }
    
    
    
      # callback to set default end_time (on create only)
      before_create :set_shift_end_time
  
  
    #methods
    
        def completed?
        # if there are no jobs associated with this shift, then it is not 
		# completed and this should return false
		return self.shift_jobs.count > 0
	end
	
    def start_now
	    self.update_attribute(:start_time, Time.current)
    end

  def end_now
    self.update_attribute(:end_time, Time.current)
  end
	
	private
    def set_shift_end_time
        self.end_time = self.start_time + (3*60*60)
    end
    
    def assignment_must_be_current
    unless self.assignment.nil? || self.assignment.end_date.nil?
      errors.add(:assignment_id, "is not a current assignment at the creamery")
    end
    end
	
	def assignment_starts
        @assignment_starts = self.assignment.start_date.to_date
    end
  
  
end
