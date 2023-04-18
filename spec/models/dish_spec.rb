require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'relationships' do
    it { should belong_to :chef }
    it { should have_many :dish_ingredients }
    it { should have_many(:ingredients).through(:dish_ingredients) }
  end

  describe 'class methods' do
    before(:each) do
      @sam = Chef.create!(name: 'Sam')

      @dish1 = @sam.dishes.create!(name: 'Breakfast Skillet', description: 'eggs, sausage, diced onions and cheddar cheese scrambled fresh in a hot skillet')
  
      @ing1 = Ingredient.create!(name: 'eggs', calories: 120)
      @ing2 = Ingredient.create!(name: 'sausage', calories: 150)
      @ing3 = Ingredient.create!(name: 'onion', calories: 100)
      @ing4 = Ingredient.create!(name: 'cheddar cheese', calories: 150)
  
      @dish_ing1 = DishIngredient.create!(dish: @dish1, ingredient: @ing1)
      @dish_ing2 = DishIngredient.create!(dish: @dish1, ingredient: @ing2)
      @dish_ing3 = DishIngredient.create!(dish: @dish1, ingredient: @ing3)
      @dish_ing4 = DishIngredient.create!(dish: @dish1, ingredient: @ing4)
    end

    describe '#total_calories' do
      it 'returns the sum of all ingredient calories' do
        expect(@dish1.total_calories).to eq(520)
      end
    end

    describe '#chef_name' do
      it 'returns the dishs chef name' do
        expect(@dish1.chef_name).to eq(@sam.name)
      end
    end
  end
end
