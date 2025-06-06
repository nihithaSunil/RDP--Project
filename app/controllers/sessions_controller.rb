class SessionsController < ApplicationController
  def new
    # render template[:new]
    # layout: 'application'
  end
  
  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      session[:cart] = {} if user.role == "customer"
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Username and/or password is invalid"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    redirect_to home_path, notice: "Logged out!"
  end
end