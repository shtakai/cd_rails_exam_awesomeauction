class SessionsController < ApplicationController

  def new
    @user = User.new
    @new_user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    logger.debug "user: #{@user}"
    logger.debug params[:password]
    if @user.present? && @user = @user.authenticate(params[:password])
      logger.debug "logged in #{@user.id}"
      flash[:notice] = "Welcome #{@user.username}"
      session[:user_id] = @user.id
      fail
    else
      logger.debug "login failed"
      flash[:alert] = "Login Failed"
      redirect_to '/'
    end
  end

  def destroy
    logger.debug "logged out"
    session.clear
    redirect_to '/'
  end

end
