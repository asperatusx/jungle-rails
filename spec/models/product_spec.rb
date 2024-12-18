require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Test Category') # Create a test category before each test

      # Create product that can be used for all it tests
      @product = Product.new(
        name: 'product test',
        price: 25.00,
        quantity: 10,
        category: @category
      )
    end
    
    it 'saves successfully if all four fields exist' do
      expect(@product).to be_valid
      expect(@product.save).to be true
    end

    it 'will not save successfully if name is empty' do
      @product.name = nil
      
      # @product.save
      # used to check what msg is outputted
      # p @product.errors.full_messages

      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'will not save successfully if price is empty' do
      @product.price = nil

      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price cannot be blank")
    end

    it 'will not save successfully if quantiy is empty' do
      @product.quantity = nil

      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'will not save successfully if category is empty' do
      @product.category = nil

      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
