require 'rails_helper'

RSpec.describe Food, type: :model do
  before do
    @user = User.create(name: 'paloma malevola', email: 'paloma_malevola@mail.com', password: 'palomapaloma')
    @egg = Food.create(name: 'egg', measurement_unit: 'piece', price: '3', quantity: 1, user: @user)
    @onion = Food.create(name: 'onion', measurement_unit: 'piece', price: '2', quantity: 1, user: @user)
  end
  it 'name should be present' do
    @egg.name = nil
    expect(@egg).to_not be_valid
  end

  it 'measurement_unit should be present' do
    @egg.measurement_unit = nil
    expect(@egg).to_not be_valid
  end

  it 'price should be present' do
    @egg.price = nil
    expect(@egg).to_not be_valid
  end

  it 'quantity should be present' do
    @egg.quantity = nil
    expect(@egg).to_not be_valid
  end

  it 'should be valid' do
    expect(@egg).to be_valid
  end

  it 'should have a user' do
    expect(@egg.user).to eq(@user)
  end

  it 'should mesaure in pieces' do
    expect(@egg.measurement_unit).to eq('piece')
  end

  it 'should have a price of 3' do
    expect(@egg.price).to eq(3)
  end

  it 'should have a quantity of 1' do
    expect(@egg.quantity).to eq(1)
  end
end
