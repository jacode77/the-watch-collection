# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

brands = ["Rolex", "Omega", "Patek Phillipe", "Piaget", "Cartier", "Jaeger-LeCoultre"]

if Brand.count == 0
    brands.each do |b|
        Brand.create(name: b)
        puts "created #{b} brand"
    end
end