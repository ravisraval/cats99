class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    Cat.create(cat_params)
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def cat_params
    params.permit(:name, :age, :sex,
    :color, :birth_date, :description)
  end
end
