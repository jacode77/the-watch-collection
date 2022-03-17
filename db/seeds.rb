# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

brands = ["Rolex", "Omega", "Patek Philippe", "Piaget", "Cartier", "Jaeger-LeCoultre", "Richard Mille", "Panerai", "Chopard", "Audemars Piguet"]

if Brand.count == 0
    brands.each do |b|
        Brand.create(name: b)
        puts "created #{b} brand"
    end
end

categories = ["Dress Watch", "Mens", "Womens", "Unisex", "Dive", "Special Edition", "Grail Watch", "Daily Wear"]

if Category.count == 0
    categories.each do |c|
        Category.create(name: c)
        puts "created #{c} category"
    end
end