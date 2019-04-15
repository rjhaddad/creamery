class Job < ApplicationRecord
  has_many :shift_jobs
  has_many :shifts, through: :shift_jobs

  validates_presence_of :name
  
  #scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  
  scope :alphabetical, order("name")
  
  before_destroy :is_destroyable?
  after_rollback :convert_to_inactive

  private
  def is_destroyable?
    @destroyable = self.shift_jobs.empty?
  end
  
  def convert_to_inactive
    make_inactive if !@destroyable.nil? && @destroyable == false
    @destroyable = nil
  end

  def make_inactive
    self.update_attribute(:active, false)
  end
  
  
end
