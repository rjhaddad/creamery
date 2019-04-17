class UsersController < ApplicationController
     def index
       @user = User.all
  end

  def show
     @user = User.all
  end

  def new
    		@user = User.new
		@user.employee_id = params[:employee_id] unless params[:employee_id].nil?
  end

  def edit
    @user = User.find(current_user)
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
    
  end

  def destroy

  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :employee_id)
  end

end
