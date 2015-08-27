# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#user = User.new
#user.email = 'admin@arcre.cl'
#user.password = 'admin123'
#user.password_confirmation = 'admin123'
#user.save!

user = User.new
user.email = 'admin@grainoils.cl'
user.password = 'admin123'
user.password_confirmation = 'admin123'
user.role = 'admin'
user.save!

product_type = ProductType.new
product_type.organic = true
product_type.code = 1
product_type.name = "aceite prueba 1"
product_type.save!

packing_types = PackingType.new
packing_types.amount = 10
packing_types.measure = "Kg"
packing_types.code = 1
packing_types.save!

product = Product.new
product.description = "prueba 1"
product.country = "780"
product.enterprise = 1
product.verifyDigit = product.getVerifyDigit
product.product_type_id = 1
product.packing_type_id = 1
product.save!

batch = Batch.new
batch.elaboration_day = 26
batch.elaboration_month = 8
batch.elaboration_year = 2015
batch.lifespan = 6
batch.daily_batch = 1
batch.intern_use_1 = 0
batch.intern_use_2 = 0
batch.verify_digit = 4
batch.product_type_id = 1
batch.description = "Lote de prueba"