class HomeController < ApplicationController

  def index
    
            @stores = Store.active.alphabetical;

  end

  def search
    @query = params[:query]
    @employees = Employee.search(@query)
    @total_hits = @employees.size
  end

  def about
  end

  def contact
  end
  
  def privacy
  end
  
end
