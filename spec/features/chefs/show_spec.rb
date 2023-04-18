require 'rails_helper'

RSpec.describe 'the Chefs show page', type: :feature do
  before(:each) do
    @sam = Chef.create!(name: 'Sam')

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
end
