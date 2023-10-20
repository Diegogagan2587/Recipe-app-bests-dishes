require 'rails_helper'

RSpec.describe 'Sign up page', type: :system do
    before :each do
        User.destroy_all
        Rails.cache.clear
    end

    it 'should redirect to login page' do
        visit root_path
        expect(page).to have_content('Log in')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Remember me')
    end

    it 'should create a new user' do
        visit root_path
        click_link 'Sign up'
        fill_in 'Name', with: 'paloma malevola'
        fill_in 'Email', with: 'paloma@mail.com'
        fill_in 'Password', with: 'palomapaloma'
        fill_in 'Password confirmation', with: 'palomapaloma'
        # Wee need to click in the input to make submission that will trigger the creation of then user
        find('input[name="commit"]').click
        expect(page).to have_content('Welcome! You have signed up successfully.')
    end

end