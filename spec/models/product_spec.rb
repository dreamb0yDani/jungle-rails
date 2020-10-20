require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @category = Category.new(name: "Apparel")
  end

  describe "Validations" do
    it "should successfuly save with all fields" do
  
      @product = Product.new(
        name: "shirt",
        price_cents: 456325,
        quantity: 3,
        category: @category
      )
      @product.save!
      
      expect(@product).to be_persisted
    end

    it "should be invalid without the name" do

      @product = Product.new(
        name: nil,
        price_cents: 456325,
        quantity: 3,
        category: @category
      )

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end

    it "should have price otherwise invalid" do

      @product = Product.new(
        name: "shirt",
        price_cents: nil,
        quantity: 3,
        category: @category
      )

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end

    it "should have quantity otherwise invalid" do

      @product = Product.new(
        name: "shirt",
        price_cents: 456325,
        quantity: nil,
        category: @category
      )

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end


    it "should have category, otherwise invalid" do

      @product = Product.new(
        name: "shirt",
        price_cents: 456325,
        quantity: 3,
        category: nil
      )

      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end
end
