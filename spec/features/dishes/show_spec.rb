require 'rails_helper'

RSpec.describe 'the Dishes show page', type: :feature do
  before(:each) do
    @sam = Chef.create!(name: 'Sam')

    @dish1 = @sam.dishes.create!(name: 'Breakfast Skillet', description: 'eggs, sausage, diced onions and cheddar cheese scrambled fresh in a hot skillet')
    @dish2 = @sam.dishes.create!(name: 'Spaghetti', description: 'spagetti pasta in red sauce with meatballs')

    @ing1 = Ingredient.create!(name: 'eggs', calories: 120)
    @ing2 = Ingredient.create!(name: 'sausage', calories: 150)
    @ing3 = Ingredient.create!(name: 'onion', calories: 100)
    @ing4 = Ingredient.create!(name: 'cheddar cheese', calories: 150)
    @ing5 = Ingredient.create!(name: 'spaghetti', calories: 170)

    @dish_ing1 = DishIngredient.create!(dish: @dish1, ingredient: @ing1)
    @dish_ing2 = DishIngredient.create!(dish: @dish1, ingredient: @ing2)
    @dish_ing3 = DishIngredient.create!(dish: @dish1, ingredient: @ing3)
    @dish_ing4 = DishIngredient.create!(dish: @dish1, ingredient: @ing4)
    @dish_ing5 = DishIngredient.create!(dish: @dish2, ingredient: @ing5)

    visit dish_path(@dish1)
  end

  describe 'User Story 1' do
    it 'displays the dish name, description, list of ingredients, total calorie count, and chefs name.' do
      expect(page).to have_content(@dish1.name)
      expect(page).to have_content(@dish1.description)
      expect(page).to have_content('Ingredients')

      within('#dish-ing') do
        @dish1.ingredients.each do |ingredient|
          expect(page).to have_content(ingredient.name)
        end
        expect(page).to_not have_content(@ing5.name)
      end

      expect(page).to have_content(@dish1.total_calories)
      expect(page).to have_content(@dish1.chef_name)
    end
  end
end
