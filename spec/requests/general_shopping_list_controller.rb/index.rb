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
        @egg = Food.create(name:'egg', measurement_unit: 'piece', price:3,  quantity:1, user:@user)
        @jam = Food.create(name:'Jam', measurement_unit: 'kg', price:45,  quantity:1, user:@user)
        @eggs_recipe = Recipe.create(name: 'Eggs with jam', preparation_time: 8, cooking_time: 15, description:'3 eggs with 2 jam', public:true, user: @user )
        required_eggs = RecipeFood.create(quantity: 3, recipe: @eggs_recipe, food:@egg )
        required_jams = RecipeFood.create(quantity: 2, recipe: @eggs_recipe, food:@jam )
    end

    describe 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_successful # response.successful?
            expect(response).to have_http_status(200)
        end
        it 'renders the index template' do
            get :index
            expect(response).to render_template('index')
        end
        it 'should containes the foods names' do
            get :index
            expect(response.body).to include('egg')
            expect(response.body).to include('Jam')
        end
        it 'should containes the foods prices' do
            get :index
            expect(response.body).to include('3')
            expect(response.body).to include('45')
        end
        it 'should containes the foods measurement_unit' do
            get :index
            expect(response.body).to include('piece')
            expect(response.body).to include('kg')
        end
    end
end