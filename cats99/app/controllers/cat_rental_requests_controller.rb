class CatRentalRequestsController < ApplicationController
  def new
    render :new
  end

  def create
    CatRentalRequest.create(rental_params)
  end

  def index
    @rentals = CatRentalRequest.all
    render :index
  end

  def show
    @rental = CatRentalRequest.find(params[:id])
    render :show
  end

  def rental_params
    params.permit(:cat_id, :start_date, :end_date)
  end

end
