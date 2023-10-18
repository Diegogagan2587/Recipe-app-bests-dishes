class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])

    if @recipe_foods.any?
      @ingredients = []
      @recipe_foods.each do |recipe_food|
        @ingredients << {
          id: recipe_food.id,
          name: Food.find_by(id: recipe_food.food_id).name,
          quantity: recipe_food.quantity,
          measurement_unit: Food.find_by(id: recipe_food.food_id).measurement_unit,
          price: recipe_food.quantity * Food.find_by(id: recipe_food.food_id).price
        }
      end
    end

    return unless @recipe.nil?

    flash[:error] = 'Recipe not found'
    redirect_to recipes_path
  end

  def public_recipe
    @recipes = Recipe.where(public: true).order(created_at: :desc).includes([:user])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe was successfully created.'
      redirect_to recipes_path
    else
      flash[:alert] = 'Something went wrong! Recipe was not created.'
      render 'new'
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    RecipeFood.where(recipe_id: @recipe.id).destroy_all

    if @recipe.destroy
      flash[:notice] = 'Recipe was successfully deleted.'
      redirect_to recipes_path
    else
      flash.now[:alert] = 'Something went wrong! Recipe was not deleted.'
      render 'show'
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
