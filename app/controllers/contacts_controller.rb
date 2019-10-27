class ContactsController < ApplicationController

  def new
    fname = params[:fname]
    lname = params[:lname]
    email = params[:email]
    body = params[:body]

    if params[:fname].blank? || params[:lname].blank? || params[:email].blank? || params[:body].blank?
      render json: {status: 'fail'}
    else
      ContactMailer.send_mail(fname, lname, email, body).deliver
      render json: {status: 'success'}
    end
  end

end
