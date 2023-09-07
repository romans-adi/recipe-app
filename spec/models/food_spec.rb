require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with a name and a non-negative price' do
    user = create(:user)
    food = Food.new(name: 'Example Food', price: 10.99, user:)
    expect(food).to be_valid
  end

  it 'is invalid without a name' do
    user = create(:user)
    food = Food.new(price: 10.99, user:)
    expect(food).to_not be_valid
  end

  it 'is invalid with a negative price' do
    user = create(:user)
    food = Food.new(name: 'Example Food', price: -5.0, user:)
    expect(food).to_not be_valid
  end
end
