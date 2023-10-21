require 'rails_helper'

RSpec.describe 'Recipe Show Page (Version 2)', type: :feature do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password123') }
  let(:recipe) do
    user.recipes.create(
      name: 'Fruit Salad',
      preparation_time: 10,
      cooking_time: 15,
      description: 'Healthy fruit salad recipe.',
      public: true
    )
  end

  before do
    User.destroy_all
    user.save
    sign_in user
  end

  context 'when displaying the recipe' do
    before { recipe.save }

    before { visit recipe_path(recipe) }

    it 'displays the recipe name' do
      expect(page).to have_content(recipe.name)
    end

    it 'displays the recipe description' do
      expect(page).to have_content(recipe.description)
    end

    it 'displays the recipe preparation time' do
      expect(page).to have_content("#{recipe.preparation_time} minutes")
    end

    it 'displays the recipe cooking time' do
      expect(page).to have_content("#{recipe.cooking_time} minutes")
    end

    it 'displays the option to add an ingredient' do
      expect(page).to have_link('+ Add Ingredient')
    end
  end

  context 'when displaying ingredients' do
    before do
      @ingredients = [
        { name: 'Ingredient 1', quantity: 2, measurement_unit: 'cups', price: 5, id: 1 },
        { name: 'Ingredient 2', quantity: 1, measurement_unit: 'tablespoon', price: 2, id: 2 }
      ]
    end

    before { visit recipe_path(recipe) }

    it 'does not display remove buttons for ingredients if the user is not the owner' do
      expect(page).not_to have_button('Remove')
    end
  end
end
