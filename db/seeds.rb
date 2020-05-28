# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

puts 'Clearing all db entries of cocktails, ingredients and doses tables'
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

puts 'Create 5 seeded cocktails'

def get_image_url(c_name)
  api_url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{c_name}"
  cocktail_serialized = open(api_url).read
  cocktail_info = JSON.parse(cocktail_serialized)
  img_url = cocktail_info['drinks'][0]['strDrinkThumb']
end

cocktails = ['Mojito', 'Bloody Mary', 'Sex on the Beach', 'Margarita', 'Pina Colada']

cocktails.each do |cocktail|
  puts "Creating cocktail #{cocktail}"
  c = Cocktail.create(name: cocktail)
  img_url = get_image_url(cocktail)
  file = URI.open(img_url)
  c.photo.attach(io: file, filename: "#{cocktail}.png", content_type: 'image/png')
end

puts 'Done creating cocktails'
