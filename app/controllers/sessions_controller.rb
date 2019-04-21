class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id


        if logged_in? and current_user.role? :employee
          redirect_to employees_path, notice: "Logged in! as employee"
        elsif logged_in? and current_user.role? :manager
          redirect_to dashboard_path, notice: "Logged in! as manager"
        elsif logged_in? and current_user.role? :admin
          redirect_to admin_home_path, notice: "Logged in! as admin"
        else
          redirect_to home_path, notice: "Logged in!"
        end
      else
        flash[:alert] = "Email or password is invalid"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end
end
