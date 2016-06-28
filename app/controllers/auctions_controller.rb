class AuctionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Auction.search params[:q]
    @auctions = @q.result
    @auctions = @auctions.running.page params[:page]
    @bidded_auctions = Auction.own current_user_id
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

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    @auction.user_id = current_user_id
    if @auction.save
      flash[:notice] = "Auction created: #{@auction.product_name}"
      logger.debug flash[:notice]
      redirect_to auction_path @auction
    else
      flash[:alert] = "Creation auction failed: #{@auction.product_name}"
      logger.debug flash[:alert]
      render 'auctions/new'
    end
  end

  private

  def auction_params
    params.require(:auction).permit(
       :product_name,
       :description,
       :starting_bid,
       :reserve_price,
       :end_date
    )
  end

end
