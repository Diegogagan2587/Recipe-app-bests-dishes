class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:public_recipe]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @recipe_foods = RecipeFood.where(recipe_id: params[:id]).includes(:food)

    return unless @recipe_foods.any?

    @ingredients = @recipe_foods.map do |recipe_food|
      {
        id: recipe_food.id,
        name: recipe_food.food.name,
        quantity: recipe_food.quantity,
        measurement_unit: recipe_food.food.measurement_unit,
        price: recipe_food.quantity * recipe_food.food.price
      }
    end
  end

  def new
    @recipe = Recipe.new
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)

    flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
    redirect_to @recipe
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

  def public_recipe
    @recipes = load_public_recipes
    @ingredients = calculate_total_ingredients(@recipes)
    calculate_totals
  end

  private

  def load_public_recipes
    Recipe.includes(:user)
      .joins(:user)
      .where(public: true)
      .order(updated_at: :desc)
      .select('recipes.*, users.name AS user_name')
  end

  def calculate_total_ingredients(recipes)
    ingredients = []

    recipes.each do |recipe|
      recipe_foods = load_recipe_foods(recipe)
      next unless recipe_foods.any?

      ingredients.concat(calculate_ingredients(recipe_foods))
    end

    ingredients
  end

  def load_recipe_foods(recipe)
    RecipeFood.where(recipe_id: recipe.id).includes(:food)
  end

  def calculate_ingredients(recipe_foods)
    recipe_foods.map do |recipe_food|
      {
        id: recipe_food.id,
        name: recipe_food.food.name,
        quantity: recipe_food.quantity,
        measurement_unit: recipe_food.food.measurement_unit,
        price: recipe_food.quantity * recipe_food.food.price
      }
    end
  end

  def calculate_totals
    @total_number_of_foods = @ingredients.length
    @total_price = @ingredients.sum { |ingredient| ingredient[:price] }
  end
end
