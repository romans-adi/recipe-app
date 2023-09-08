require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should have_many(:foods).dependent(:destroy) }
    it { should have_many(:recipes).dependent(:destroy) }
  end

  it 'validates email uniqueness case-insensitively with custom message' do
    FactoryBot.create(:user, email: 'user@example.com')
    new_user = FactoryBot.build(:user, email: 'USER@example.com')

    expect(new_user).not_to be_valid
    expect(new_user.errors[:email]).to include('This email address is already in use.')
  end

  describe '#admin?' do
    it 'returns true for users with admin role' do
      user.update(role: 'admin')
      expect(user.admin?).to be_truthy
    end

    it 'returns false for users with non-admin role' do
      user.update(role: 'user')
      expect(user.admin?).to be_falsy
    end
  end

  it 'returns the shopping list and total price' do
    food1 = FactoryBot.create(:food, name: 'Food1', price: 5.0)
    food2 = FactoryBot.create(:food, name: 'Food2', price: 3.0)
    recipe_food1 = FactoryBot.create(:recipe_food, food: food1, quantity: 2)
    recipe_food2 = FactoryBot.create(:recipe_food, food: food2, quantity: 3)

    shopping_list, = user.general_shopping_list([recipe_food1, recipe_food2])
    expected_shopping_list = [
      { name: 'Food1', quantity: 2, price: 5.0 },
      { name: 'Food2', quantity: 3, price: 3.0 }
    ]
    expect(shopping_list).to include(*expected_shopping_list)
  end
end
