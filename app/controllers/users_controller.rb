class UsersController < ApplicationController

  def create
    @new_user = User.new user_params
    if @new_user.save
      logger.debug "Register user #{@new_user.username}"
      flash[:notice] = "User Registered"
      redirect_to '/'
    else
      logger.debug "Register Failed #{@new_user.username} #{@new_user.errors.messages}"
      flash[:notice] = "Failed Registration"
      @user = User.new
      render 'sessions/new'
    end

  end


  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email,
                                :password, :password_confirmation )
  end
end
