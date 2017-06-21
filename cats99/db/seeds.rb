# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Cat.create(birth_date: Date.new(2017,6,10), name: "notdog", sex: "F", color: "black", description: "totally not a dog")
c2 = Cat.create(birth_date: Date.new(2017,6,15), name: "probablynotdog", sex: "M", color: "white", description: "probably not a dog")


CatRentalRequest.create(cat_id: c1.id, start_date: Date.new(2017,7,1), end_date: Date.new(2017,7,4))
CatRentalRequest.create(cat_id: c1.id, start_date: Date.new(2017,7,3), end_date: Date.new(2017,7,8))
