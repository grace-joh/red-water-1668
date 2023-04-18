class Chefs::IngredientsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @chef = Chef.find(params[:chef_id])
    @ingredients = @chef.ingredients.distinct # will this work?!
  end
end
