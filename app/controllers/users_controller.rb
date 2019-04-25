class UsersController < ApplicationController
  # everyone can run new and create actions, but only those actions
	before_action :check_login, :except => [:new, :create]
	before_action :set_user, only:[:edit, :update]
	authorize_resource
	
     def index
       @users = User.all
  end

  def show
     @user = User.find(params[:id])
  end

  def new
    		@user = User.new
		@user.employee_id = params[:employee_id] unless params[:employee_id].nil?
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    
    # get current user from current_user method
		@user = current_user
		if @user.update_attributes(user_params)
		  # when a new user is saved, add the user_id to the session hash
		  # session[:user_id] = @user.id	
		  redirect_to(user_path, :notice => 'User was successfully updated.')
		else
		  render :action => "edit"
		end	
	end
    
    


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.proper_name} from website."
    redirect_to users_url
  end

  private
  def set_user
    @user = current_user
  end
  
 def user_params
      if current_user && current_user.role?(:admin)
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :active)  
      else
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :active)
      end
    end

end
