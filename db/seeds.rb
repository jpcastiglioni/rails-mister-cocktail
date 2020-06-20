# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "Erradicating database for good"

Ingredient.destroy_all

puts "Seeding ingredients from the cocktailbd"

# Ingredient.create(name: "lemon")
# Ingredient.create(name: "ice")
# Ingredient.create(name: "mint leaves")

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_json = open(url).read
ingredient_hash = JSON.parse(ingredient_json)
ingredient_array = ingredient_hash['drinks']

ingredient_array.each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

# puts "#{user['name']} - #{user['bio']}"
