# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

role = Role.create(name: 'admin')
user = User.create( :email => "admin@localhost.localhost", :password => "teatrodebarrio", :password_confirmation => "teatrodebarrio")

role.memberships.create( user: user)

(1..5).each { |i|

User.create( :email => "usuario#{i}@manolito.gafotas", :password => "usuario#{i}", :password_confirmation => "usuario#{i}")

}
