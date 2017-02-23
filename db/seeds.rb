# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach(Rails.root.join("db/seeds/countries.csv"), headers: true) do |row|
  country = Country.find_or_initialize_by(iso3: row["iso3"])
  country.name = row["name"]
  country.save
end
