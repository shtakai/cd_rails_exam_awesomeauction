class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :balance, if: :user_signed_in?

  protected

  def authenticate_user!
    if !user_signed_in?
      redirect_to '/' and return
    end
  end

  def user_signed_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user_id
    session[:user_id]
  end

  def balance
    @balance = current_user.wallet.balance
  end


end
