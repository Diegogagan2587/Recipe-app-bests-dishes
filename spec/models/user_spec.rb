require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(name: 'paloma malevola',
                        email: 'paloma_malevola@mail.com',
                        password: 'palomapaloma')
  end
  it 'should have a name' do
    expect(@user.name).to eq('paloma malevola')
  end
  it 'should have a email' do
    expect(@user.email).to eq('paloma_malevola@mail.com')
  end
  it 'should have a password' do
    expect(@user.password).to eq('palomapaloma')
  end
end
