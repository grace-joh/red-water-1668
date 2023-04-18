class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes

  def top_three_ingredients
    joins(dishes: :ingredients)
    .select('ingredients.*, COUNT(ingredients.*) as ing_count')
    .group(:ingredient_id)
    .order("ing_count DESC")
    .limit(3)
  end
end
