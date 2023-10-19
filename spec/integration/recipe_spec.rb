require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :view do
  describe 'integration tests for recipes page' do
    before(:each) do
      @user = User.create(name: 'Ruth', email: 'ruth@gmail.com', password: '7410')
      sign_in @user

      @recipe1 = Recipe.create(name: 'burger', user_id: @user.id, preparation_time: 34, cooking_time: 45,
                               description: 'test recipe 1', public: true)
      @recipe2 = Recipe.create(name: 'tea', user_id: @user.id, preparation_time: 34, cooking_time: 45,
                               description: 'test recipe 2', public: true)
      @recipe3 = Recipe.create(name: 'pizza', user_id: @user.id, preparation_time: 34, cooking_time: 45,
                               description: 'test recipe 3', public: true)

      allow(view).to receive(:current_user).and_return(@user)

      allow(view).to receive(:user_signed_in?).and_return(true)

      assign(:recipes, [@recipe1, @recipe2, @recipe3])

      render
    end

    scenario 'check if recipes are available' do
      expect(rendered).to have_content 'burger'
      expect(rendered).to have_content 'tea'
      expect(rendered).to have_content 'pizza'
    end
  end
end
