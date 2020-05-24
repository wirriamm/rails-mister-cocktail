# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts 'Clearing all db entries for cocktails, ingredients and doses tables'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Seeding ingredients from API'
ingredients_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(ingredients_url).read
ingredients = JSON.parse(ingredients_serialized)
ingredients['drinks'].each do |hash|
  ingredient = Ingredient.new({ name: hash['strIngredient1'] })
  ingredient.save!
  puts "  Saved ingredient: #{hash['strIngredient1']}"
end
puts 'Saved all ingredients'
