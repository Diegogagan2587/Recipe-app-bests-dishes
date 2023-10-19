require 'rails_helper'

RSpec.describe User, type: :model do
  Food.destroy_all
  Recipe.destroy_all
  User.destroy_all
  user = User.create(
    name: 'Test User',
    email: 'test@example.com',
    password: 'password123'
  )

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'is not valid with a duplicate email address' do
    user2 = User.create(
      name: 'Another User',
      email: 'test@example.com',
      password: 'password123'
    )
    expect(user2.errors[:email]).to include('has already been taken')
  end

  it 'is not valid with a name longer than 20 characters' do
    user.name = 'ThisIsANameThatIsTooLongToBeValid'
    expect(user).to_not be_valid
  end
end
