require 'rails_helper'

RSpec.describe 'the Chef Ingredients index page', type: :feature do
  before(:each) do
    @sam = Chef.create!(name: 'Sam')
    @leo = Chef.create!(name: 'Leo')

    @dish1 = @sam.dishes.create!(name: 'Breakfast Skillet', description: 'eggs, sausage, diced onions and cheddar cheese scrambled fresh in a hot skillet')
    @dish2 = @sam.dishes.create!(name: 'Spaghetti', description: 'spagetti pasta in red sauce with meatballs')
    @dish3 = @leo.dishes.create!(name: 'Dog Food', description: 'anything Leo likes')

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
    @dish_ing4 = DishIngredient.create!(dish: @dish2, ingredient: @ing5)
    @dish_ing4 = DishIngredient.create!(dish: @dish3, ingredient: @ing6)

    visit chef_ingredients_path(@sam)
  end

  describe 'User Story 3' do
    it 'displays a unique list of all ingredients the chef uses' do
      expect(page).to have_content("Ingredients for Chef #{@sam.name}")

      within("#chef-#{@sam.id}-ing") do
        @sam.ingredients.each do |ingredient|
          expect(page).to have_content(ingredient.name)
        end
        expect(page).to have_content(@ing3.name, count: 1)
        expect(page).to_not have_content(@ing6.name)
      end
    end
  end
end
