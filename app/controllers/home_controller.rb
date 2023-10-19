class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @lastest_public_recipes = Recipe.where(public: true).order(created_at: :desc).limit(10)
    @user_lastest_recipes = current_user.recipes.order(created_at: :desc).limit(10)
    @user_lastest_foods = current_user.foods.order(created_at: :desc).limit(10)
  end
end
