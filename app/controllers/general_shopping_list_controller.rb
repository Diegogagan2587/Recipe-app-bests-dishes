class GeneralShoppingListController < ApplicationController
  def index
    @recipefoods = current_user.recipe_foods
    @shopping_list = Hash.new { |hash, key| hash[key] = { quantity: 0, price: 0 } }
    @recipefoods.each do |recipefood|
      food = Food.find(recipefood.food_id)
      if food.quantity.zero?
        @shopping_list[food.name][:quantity] += recipefood.quantity
        @shopping_list[food.name][:price] += food.price * @shopping_list[food.name][:quantity]
      elsif food.quantity < recipefood.quantity
        @shopping_list[food.name][:quantity] += recipefood.quantity - food.quantity
        @shopping_list[food.name][:price] += food.price * @shopping_list[food.name][:quantity]
      end
    end
  end
end
