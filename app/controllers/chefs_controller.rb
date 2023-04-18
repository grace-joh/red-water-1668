class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
    @top = @chef.top_three_ingredients
    require 'pry'; binding.pry
  end
end
