require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before do
    @user = User.create(name: 'paloma malevola', email: 'paloma_malevola@mail.com', password: 'palomapaloma')
    # we create some fooed that will be reference by RecipeFood
    @egg = Food.create(name: 'egg', measurement_unit: 'piece', price: 3, quantity: 1, user: @user)
    @jam = Food.create(name: 'Jam', measurement_unit: 'kg', price: 45, quantity: 1, user: @user)
    # then we create user->recipe->recipe_food with the food created

    @eggs_recipe = Recipe.create(name: 'Eggs with jam', preparation_time: 8, cooking_time: 15,
                                 description: '3 eggs with 2 jam', public: true, user: @user)

    # Lastly we create the models that will be tested with references to the previous models
    @required_eggs = RecipeFood.create(quantity: 3, recipe: @eggs_recipe, food: @egg)
    @required_jams = RecipeFood.create(quantity: 2, recipe: @eggs_recipe, food: @jam)
  end

  it 'eggs should have a quantity of 3' do
    expect(@required_eggs.quantity).to eq(3)
  end

  it 'jams should have a quantity of 2' do
    expect(@required_jams.quantity).to eq(2)
  end

  it 'eggs should have a recipe' do
    puts 'evaluating failure'
    expect(@required_eggs.recipe).to eq(@eggs_recipe)
  end

  it 'jams should have a recipe' do
    expect(@required_jams.recipe).to eq(@eggs_recipe)
  end

  it 'eggs should have a food' do
    expect(@required_eggs.food).to eq(@egg)
  end

  it 'jams should have a food' do
    expect(@required_jams.food).to eq(@jam)
  end
end
