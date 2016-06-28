class TopupsController < ApplicationController
  before_action :authenticate_user!
  before_action :wallet_balance, only: [:new, :create]

  def new
    @topup = current_user.wallet.topups.new
  end

  def create
    @topup = current_user.wallet.topups.new topup_params
    saved = false

    @topup.with_lock do
      #current_user.wallet.balance += @topup.amount
      #current_user.wallet.save!
      wallet = current_user.wallet
      wallet.balance += @topup.amount
      @topup.save!
      wallet.save!
      logger.debug "topup ok"
      logger.debug "wallet ballance: #{current_user.wallet.to_json}"
      saved = true
    end

    if saved
      flash[:notice] = "Topup $ #{@topup.amount}"
      logger.debug flash[:notice]
      redirect_to '/auctions'
    else
      flash[:alert] = "Topup failed"
      @topup = current_user.wallet.topups.new
      render 'topups/new'
    end
  end

  private

  def topup_params
    params.require(:topup).permit(:amount)
  end

  def wallet_balance
    @balance = current_user.wallet.balance
  end

end
