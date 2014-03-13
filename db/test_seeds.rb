# This file should contain all the record creation needed to seed the database with data for testing.
# 
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Taxonomy.destroy_all
Taxonomy.create :name => "taxonomy 1", :id => 1
