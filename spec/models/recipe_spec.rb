require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(name: 'Test User', email: 'test@example.com', password: 'password123')
    recipe = Recipe.new(
      name: 'Fruit Salad',
      preparation_time: 10,
      cooking_time: 15,
      description: 'Healthy fruit salad recipe',
      public: true,
      user: user
    )
    expect(recipe).to be_valid
  end

  it 'is not valid without a user id' do
    recipe = Recipe.new(
      name: 'Fruit Salad',
      preparation_time: 10,
      cooking_time: 15,
      description: 'Healthy fruit salad recipe',
      public: true,
      user_id: nil
    )
    expect(recipe).to_not be_valid
  end

  it 'is not valid with a user id that does not exist' do
    recipe = Recipe.new(
      name: 'Fruit Salad',
      preparation_time: 10,
      cooking_time: 15,
      description: 'Healthy fruit salad recipe',
      public: true,
      user_id: 1000
    )
    expect(recipe).to_not be_valid
  end
end
