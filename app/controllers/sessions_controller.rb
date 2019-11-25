class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.locked == true && user.locked_at > DateTime.now - (1.0/24.0)
      flash[:danger] = "Your account is locked"
      redirect_to admin_path
    # user's account is either not locked or an hour has passed 
    else
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        user.login_attempts = 0
        user.locked = false
        redirect_to admin_panel_path
      else
        user.increment!(:login_attempts)
        if user.login_attempts == 4
          user.locked = true
          user.locked_at = DateTime.now
          flash[:danger] = "Your account has been locked. Try again in 1 hour"
          redirect_to admin_path
        end
        flash[:danger] = "Invalid credentials. Please try again"
        redirect_to admin_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_path
  end
end
