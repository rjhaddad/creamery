class User < ApplicationRecord
    has_secure_password

  # Relationships
  belongs_to :employee

  # Validations
  validates_uniqueness_of :email, case_sensitive: false, on: :create
  validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format"
  # validate :employee_is_active_in_system, on: :update
  validates_presence_of :password, on: :create
  validates_confirmation_of :password, message: "doesn't match confirmation"
  validates_length_of :password, minimum: 4, allow_blank: true

  ROLES = [['Administrator', :admin],['Manager', :manager],['Employee', :employee]]

  def role?(authorized_role)
    return false if (self.employee.nil? || self.employee.role.nil?)
    self.employee.role.to_sym == authorized_role
  end
  
  def self.authenticate(email,password)
    find_by_email(email).try(:authenticate, password)
  end

  def proper_name
    "#{self.employee.proper_name}"
  end

  # private
  # def employee_is_active_in_system
  #   is_active_in_system(:employee)
  # end

end
