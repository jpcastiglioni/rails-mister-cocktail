# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

if Ingredient.count < 3

  puts 'Erradicating ingredients.'
  Ingredient.destroy_all

  puts 'Seeding ingredients from the cocktailbd.'

  url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
  ingredient_json = open(url).read
  ingredient_hash = JSON.parse(ingredient_json)
  ingredient_array = ingredient_hash['drinks']

  ingredient_array.each do |ingredient|
    Ingredient.create!(name: ingredient['strIngredient1'])
  end

  Ingredient.create!(name: 'Mint')
  Ingredient.create!(name: 'Soda water')
  Ingredient.create!(name: 'Campari')

  puts "Ingredients seeded."

else
  puts 'Ingredients already seeded!'
end

def seed_cocktail(cocktail, doses)
  file = URI.open("https://source.unsplash.com/500x400/?#{cocktail.name}")
  cocktail.photo.attach(io: file,
                        filename: "#{cocktail.name}.png",
                        content_type: 'image/png')
  if cocktail.save
    doses.each do |ingr|
      dose = Dose.new(description: ingr[:desc])
      dose.ingredient = Ingredient.find_by(name: ingr[:ingr])
      dose.cocktail = cocktail
      dose.save!
    end
    puts "#{cocktail.name} created!"
  else
    puts "#{cocktail.name} already created!"
  end
end

puts 'Creating Mojito!'

mojito = Cocktail.new(name: 'Mojito')
mojito_doses = [
  { ingr: 'Lime', desc: 'Juice of 1' },
  { ingr: 'Light rum', desc: '2-3 oz' },
  { ingr: 'Sugar', desc: '2 tsp' },
  { ingr: 'Mint', desc: '2-4' },
  { ingr: 'Soda water', desc: '.' }
]

seed_cocktail(mojito, mojito_doses)

# if mojito.save
#   mojito_doses.each do |ingr|
#     dose = Dose.new(description: ingr[:desc])
#     dose.ingredient = Ingredient.find_by(name: ingr[:ingr])
#     dose.cocktail = mojito
#     dose.save!
#   end
#   puts 'Mojito created!'
# else
#   puts 'Mojito already created!'
# end

puts 'Creating Negroni!'

negroni = Cocktail.new(name: 'Negroni')
negroni_doses = [
  { ingr: 'Gin', desc: '1 oz' },
  { ingr: 'Campari', desc: '1 oz' },
  { ingr: 'Sweet Vermouth', desc: '1 oz' }
]

seed_cocktail(negroni, negroni_doses)
# if negroni.save
#   negroni_doses.each do |ingr|
#     dose = Dose.new(description: ingr[:desc])
#     dose.ingredient = Ingredient.find_by(name: ingr[:ingr])
#     dose.cocktail = negroni
#     dose.save!
#   end
#   puts 'Negroni created!'
# else
#   puts 'Negroni already created!'
# end

puts 'Creating Daiquiri!'

daiquiri = Cocktail.new(name: 'Daiquiri')
daiquiri_doses = [
  { ingr: 'Light rum', desc: '1 1/2 oz' },
  { ingr: 'Lime', desc: 'Juice of 1/2' },
  { ingr: 'Sugar', desc: '1 tsp' }
]

seed_cocktail(daiquiri, daiquiri_doses)

# if daiquiri.save
#   daiquiri_doses.each do |ingr|
#     dose = Dose.new(description: ingr[:desc])
#     dose.ingredient = Ingredient.find_by(name: ingr[:ingr])
#     dose.cocktail = daiquiri
#     dose.save!
#   end
#   puts 'Daiquiri created!'
# else
#   puts 'Daiquiri already created!'
# end
