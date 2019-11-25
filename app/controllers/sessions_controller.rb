class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) &&
       (user.locked == false || user.locked_at <= DateTime.now - (1/24.0))
      session[:user_id] = user.id
      user.login_attempts = 0
      redirect_to admin_panel_path
    else
      user.increment!(:login_attempts)
      if user.login_attempts = 4
        user.locked = true
        user.locked_at = DateTime.now
        flash[:danger] = "Your account has been locked."
        redirect_to admin_path
      end
      flash[:danger] = "Invalid credentials. Please try again"
      redirect_to admin_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_path
  end
end
