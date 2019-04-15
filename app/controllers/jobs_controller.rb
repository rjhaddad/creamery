class JobsController < ApplicationController
    
    before_action :set_job, only: [:show, :edit, :update, :destroy]
    #authorize_resource
  
	def index
    @active_jobs = Job.active.alphabetical.paginate(page: params[:active_jobs]).per_page(10)
    @inactive_jobs = Job.inactive.alphabetical.paginate(page: params[:inactive_jobs]).per_page(10)  
	end
	
	def show
		@job = Job.find(params[:id])
	end

	def new
		@job = Job.new
	end

	def edit
		@job = Job.find(params[:id])
	end

	def create
	    @job = Job.new(job_params)
		
		if @job.save
		redirect_to job_path(@job), notice: "Successfully created #{@job.name}."
        else
            render action: 'new'
        end
	end

  def update
    if @job.update(job_params)
      redirect_to job_path(@job), notice: "Successfully updated #{@job.name}."
    else
      render action: 'edit'
    end
  end

    def destroy
      @job = Job.find(params[:id])
      @job.destroy
      flash[:notice] = "Successfully removed #{@job.name} from the system."
      redirect_to jobs_url
    end
    
    private
    
    def set_job
    @job = Job.find(params[:id])
    end
  
    def job_params
    params.require(:job).permit(:name, :description, :active)
    end
	
end
