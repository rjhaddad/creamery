class Flavor < ApplicationRecord
        
    #Relationships
    has_many :store_flavors
    has_many :stores, through: :store_flavors
    
    # Validations
    validates_presence_of :name
    
    # Scopes
    scope :active,       -> { where(active: true) }
    scope :inactive,     -> { where(active: false) }
    scope :alphabetical, -> { order(:name) }
  
   private
   
  def is_destroyable?
    @destroyable = false
  end
  
  def convert_to_inactive
    make_inactive if !@destroyable.nil? && @destroyable == false
    @destroyable = nil
  end

  def make_inactive
    self.update_attribute(:active, false)
  end 
  
end
