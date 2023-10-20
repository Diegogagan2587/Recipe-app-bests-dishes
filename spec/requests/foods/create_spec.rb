require 'rails_helper'
require 'devise'
require 'warden'

RSpec.describe FoodsController, type: :controller do
  include Devise::Test::ControllerHelpers
  def sign_in(user)
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, { scope: :user })
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
  before :each do
    @user = User.create(name: 'paloma malevola', email: 'paloma_malevola@mail.com', password: 'palomapaloma')
    sign_in @user
  end
  describe 'POST #create' do
    it 'creates a new food' do
      expect do
        post :create,
             params: { food: { name: 'egg', measurement_unit: 'piece', price: 3, quantity: 1, user: @user } }
      end.to change(Food, :count).by(1)
    end
    it 'redirects to the foods index' do
      post :create,
           params: { food: { name: 'egg', measurement_unit: 'piece', price: 3, quantity: 1, user: @user } }
      expect(response).to redirect_to(foods_path)
    end
    it 'renders the new template if the food is not created' do
      post :create,
           params: { food: { name: 'egg', measurement_unit: 'piece', price: nil, quantity: nil, user: @user } }
      expect(response).to render_template('new')
    end
  end
end
