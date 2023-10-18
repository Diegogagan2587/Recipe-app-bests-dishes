class FoodsController < ApplicationController
  def index; 
    @foods = current_user.foods
  end

  def show; end

  def new
    @user = current_user
    @food = Food.new(
      user: @user
    )
    respond_to do |format|
      format.html do
        render :new
      end
    end
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
  
    respond_to do |format|
      format.html do
        if @food.save
          flash[:success] = 'Food was successfully created.'
          redirect_to foods_path
        else
          flash.now[:error] = 'Food could not be created.'
          render :new
        end
      end
    end
  end

  def delete_food
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  private
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
