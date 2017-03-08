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

wdpa_release_files = Dir.glob("#{Rails.root.join("db/seeds/wdpa_releases")}/**/*.csv")

wdpa_release_files.each do |release_file|
  release_name = File.basename(release_file, ".csv")
  released_at = DateTime.parse(release_name)

  if WdpaRelease.where(name: release_name).first.nil?
    wdpa_ids = CSV.read(release_file).flatten
    pas = ProtectedArea.where(wdpa_id: wdpa_ids)

    wdpa_release = WdpaRelease.create(name: release_name, created_at: released_at)
    wdpa_release.protected_areas = pas
  end
end

roles = ["Admin", "Team"]
roles.each { |r| Role.where(name: r).first_or_create }

if Rails.env.development?
  user = User.find_or_initialize_by(email: "test@test.com", role: Role.find_by_name("admin"))
  user.password = user.password_confirmation = "test1234"
  user.save
end
