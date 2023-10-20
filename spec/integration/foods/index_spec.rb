require 'rails_helper'

RSpec.describe 'Foods Page', type: :system do
    before :each do
        Food.destroy_all
        User.destroy_all
        Rails.cache.clear
        @user = User.create(name: 'paloma malevola', email:'paloma_malevola@mail.com',password:'palomapaloma')
        @egg = Food.create(name:'egg', measurement_unit: 'piece', price:3,  quantity:1, user:@user)
        @jam = Food.create(name:'Jam', measurement_unit: 'kg', price:45,  quantity:1, user:@user)
    end

    context 'when user is not logged in' do
        it 'should redirect to login page' do
            visit foods_path
           
            expect(page).to have_content('Log in')
            expect(page).to have_content('Email')
            expect(page).to have_content('Password')
            expect(page).to have_content('Remember me')
        end
    end

    it 'should show the foods and related data' do
        visit root_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        click_link 'Food'
        expect(page).to have_content('Food')
        expect(page).to have_content('egg')
        expect(page).to have_content('piece')
        expect(page).to have_content('$ 3.0')
        expect(page).to have_content('1')
        expect(page).to have_content('Jam')
        expect(page).to have_content('kg')
        expect(page).to have_content('$ 45.0')
    end

    it 'should create a new food' do
        visit foods_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        click_link 'Food'
        click_button 'Add Food'
        
        fill_in 'Name', with: 'apple'
        fill_in 'Measurement unit', with: 'unit'
        fill_in 'Price', with: '2'
        fill_in 'Quantity', with: '1'
        click_button 'Create Food'
        
        expect(page).to have_content('Add Food')
        expect(page).to have_content('Food')
        expect(page).to have_content('Measurement Unit')
        expect(page).to have_content('Price')
        expect(page).to have_content('apple')
        expect(page).to have_content('unit')
        expect(page).to have_content('$ 2.0')
        expect(page).to have_content('1')
    end

    it 'should delete a food' do
        visit root_path
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        click_button 'Log in'
        click_link 'Food'
        # we click on the first delete button
        first(:button, 'Delete').click
        # we spect page no not have egg, piece, $ 3.0,
        expect(page).to_not have_content('egg')
        expect(page).to_not have_content('piece')
        expect(page).to_not have_content('$ 3.0')
    end
end