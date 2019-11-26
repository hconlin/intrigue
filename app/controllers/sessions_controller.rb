class SessionsController < ApplicationController
  include ActionView::Helpers::DateHelper

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user.locked_at.present? && user.locked_at > DateTime.now - 1.hour
      time_diff = (user.locked_at + 1.hour).to_i - DateTime.now.to_i
      time_left = (time_diff / 1.minute).round
      flash[:danger] = "Your account is locked. Try again in " + time_left + " minutes"
      redirect_to admin_path
    # user's account is either not locked or an hour has passed
    else
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        user.login_attempts = 0
        user.locked_at = nil
        user.save
        redirect_to admin_panel_path
      else
        if user.locked_at.present? && user.locked_at < DateTime.now - 1.hour
          user.login_attempts = 1
          user.locked_at = nil
          user.save
        else
          #increment login attempts
          user.increment!(:login_attempts)
          if user.login_attempts == 4
            user.locked_at = DateTime.now
            user.save
            time_diff = (user.locked_at + 1.hour).to_i - DateTime.now.to_i
            time_left = (time_diff / 1.minute).round
            flash[:danger] = "Your account is locked. Try again in " + time_left + " minutes"
            redirect_to admin_path
          else
            flash[:danger] = "Invalid credentials. Please try again"
            redirect_to admin_path
          end
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_path
  end
end
