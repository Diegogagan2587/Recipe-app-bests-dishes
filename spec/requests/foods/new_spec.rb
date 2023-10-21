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
  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful # response.successful?
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
