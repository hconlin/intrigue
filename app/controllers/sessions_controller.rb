class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user.locked == true && user.locked_at.present? && user.locked_at > DateTime.now - (1.0/24.0)
      time = user.locked_at - DateTime.now - (1.0/24.0)
      time_left = time.strftime("%I:%M %P")
      flash[:danger] = "Your account is locked. It will unlock in " + time_left
      redirect_to admin_path
    # user's account is either not locked or an hour has passed
    else
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        user.login_attempts = 0
        user.locked = false
        redirect_to admin_panel_path
      else
        if user.locked_at.present? && user.locked_at <= DateTime.now - (1.0/24.0)
          user.login_attempts = 0
        end
        #increment login attempts
        user.increment!(:login_attempts)
        if user.login_attempts == 4
          user.locked = true
          user.locked_at = DateTime.now
          flash[:danger] = "Your account has been locked. Try again in 1 hour"
          redirect_to admin_path
        else
          flash[:danger] = "Invalid credentials. Please try again"
          redirect_to admin_path
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_path
  end
end
