require 'rails_helper'

RSpec.describe 'the Chefs show page', type: :feature do
  before(:each) do
    @sam = Chef.create!(name: 'Sam')

    @dish1 = @sam.dishes.create!(name: 'Breakfast Skillet', description: 'eggs, sausage, diced onions and cheddar cheese scrambled fresh in a hot skillet')
    @dish2 = @sam.dishes.create!(name: 'Spaghetti', description: 'weird spagetti pasta with eggs')
    @dish3 = @sam.dishes.create!(name: 'Dog Food', description: 'food for the best dog in the world')
    @dish4 = @sam.dishes.create!(name: 'Eggs Sausage and Salmon', description: 'because we need to test this')

    @ing1 = Ingredient.create!(name: 'eggs', calories: 120)
    @ing2 = Ingredient.create!(name: 'sausage', calories: 150)
    @ing3 = Ingredient.create!(name: 'onion', calories: 100)
    @ing4 = Ingredient.create!(name: 'cheddar cheese', calories: 150)
    @ing5 = Ingredient.create!(name: 'spaghetti', calories: 170)
    @ing6 = Ingredient.create!(name: 'salmon', calories: 130)

    @dish_ing1 = DishIngredient.create!(dish: @dish1, ingredient: @ing1)
    @dish_ing2 = DishIngredient.create!(dish: @dish1, ingredient: @ing2)
    @dish_ing3 = DishIngredient.create!(dish: @dish1, ingredient: @ing3)
    @dish_ing4 = DishIngredient.create!(dish: @dish1, ingredient: @ing4)
    @dish_ing5 = DishIngredient.create!(dish: @dish2, ingredient: @ing3)
    @dish_ing6 = DishIngredient.create!(dish: @dish2, ingredient: @ing5)
    @dish_ing7 = DishIngredient.create!(dish: @dish3, ingredient: @ing6)
    @dish_ing8 = DishIngredient.create!(dish: @dish2, ingredient: @ing1)
    @dish_ing9 = DishIngredient.create!(dish: @dish3, ingredient: @ing1)
    @dish_ing10 = DishIngredient.create!(dish: @dish1, ingredient: @ing6)
    @dish_ing11 = DishIngredient.create!(dish: @dish4, ingredient: @ing1)
    @dish_ing12 = DishIngredient.create!(dish: @dish4, ingredient: @ing2)
    @dish_ing13 = DishIngredient.create!(dish: @dish4, ingredient: @ing6)

    visit chef_path(@sam)
  end

  describe 'User Story 3' do
    it 'displays chef name' do
      expect(page).to have_content(@sam.name)
    end

    it 'displays a link to view a list of all ingredients the chef uses' do
      expect(page).to have_link("Ingredients that Chef #{@sam.name} uses")

      click_link("Ingredients that Chef #{@sam.name} uses")

      expect(current_path).to eq(chef_ingredients_path(@sam))
    end
  end

  describe 'Extension' do
    it 'displays the top 3 ingredients' do
      expect(page).to have_content("Top Three Ingredients")
      expect(page).to have_content(@ing1.name)
      expect(page).to have_content(@ing2.name)
      expect(page).to have_content(@ing6.name)
    end
  end
end
