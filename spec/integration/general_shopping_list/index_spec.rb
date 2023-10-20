require 'rails_helper'

RSpec.describe 'ShoppingList Page', type: :system do
    before :each do
        RecipeFood.destroy_all
        Recipe.destroy_all
        Food.destroy_all
        User.destroy_all
        Rails.cache.clear
        @user = User.create(name: 'paloma malevola', email:'paloma_malevola@mail.com',password:'palomapaloma')
        @egg = Food.create(name:'egg', measurement_unit: 'piece', price:3,  quantity:1, user:@user)
        @jam = Food.create(name:'Jam', measurement_unit: 'kg', price:45,  quantity:1, user:@user)
        @eggs_recipe = Recipe.create(name: 'Eggs with jam', preparation_time: 8, cooking_time: 15, description:'3 eggs with 2 jam', public:true, user: @user )
        required_eggs = RecipeFood.create(quantity: 3, recipe: @eggs_recipe, food:@egg )
        required_jams = RecipeFood.create(quantity: 2, recipe: @eggs_recipe, food:@jam )
    end

    it 'should aks for authentication before accesing' do
        visit general_shopping_list_index_path
        expect(page).to have_content('Log in')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Remember me')
    end

    it 'should show the shopping list' do
        visit root_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        click_link 'Shopping List'
        expect(page).to have_content('Shopping List')
        expect(page).to have_content('egg')
        expect(page).to have_content('2')
        expect(page).to have_content('$ 6.0')
        expect(page).to have_content('Jam')
        expect(page).to have_content('1')
        expect(page).to have_content('$ 45.0')
        expect(page).to have_content('Amount of food items to buy: 3')
        expect(page).to have_content('Total value of food needed: $ 51.0')
    end
end