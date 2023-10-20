require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @user = User.create(name: 'paloma malevola', email: 'paloma_malevola@mail.com', password: 'palomapaloma')
    @eggs_recipe = Recipe.create(name: 'Eggs with jam',
                                 preparation_time: 8,
                                 cooking_time: 15,
                                 description: '3 eggs with 2 jam',
                                 public: true, user: @user)
  end
  it 'eggs should have a name' do
    expect(@eggs_recipe.name).to eq('Eggs with jam')
  end
  it 'eggs should have a preparation_time' do
    expect(@eggs_recipe.preparation_time).to eq('8')
  end
  it 'eggs should have a cooking_time' do
    expect(@eggs_recipe.cooking_time).to eq('15')
  end
  it 'eggs should have a description' do
    expect(@eggs_recipe.description).to eq('3 eggs with 2 jam')
  end
  it 'eggs should have a public' do
    expect(@eggs_recipe.public).to eq(true)
  end
  it 'eggs should have a user' do
    expect(@eggs_recipe.user).to eq(@user)
  end
end
