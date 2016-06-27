class AuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @auctions = Auction.running.page(params[:page])
  end

  def destroy
    auction = Auction.find_by id: params[:id]
    if auction.destroy_with_user session[:user_id]
      logger.debug "auction #{auction.id} deleted"
      flash[:notice] = "auction #{auction.id} #{auction.product_name} deleted"
    else
      logger.debug "auction deletion failed #{auction.id}"
      flash[:alert] = "auction deletion failed #{auction.id}"
    end
    redirect_to '/auctions'
  end

  def show
    @auction = Auction.find_by id: params[:id]
  end

end
