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

all_ids = ProtectedArea.pluck(:wdpa_id, :id)
ids_by_wdpa_ids = Hash[all_ids]

wdpa_release_files.each do |release_file|
  release_name = File.basename(release_file, ".csv")
  released_at = DateTime.parse(release_name)

  if WdpaRelease.where(name: release_name).first.nil?
    wdpa_release = WdpaRelease.create(name: release_name, created_at: released_at)

    ProtectedAreasWdpaRelease.transaction do
      CSV.foreach(release_file, headers: true) do |row|
        id = ids_by_wdpa_ids[row["wdpa_id"].to_i]
        unless id
          pa = ProtectedArea.new(wdpa_id: row["wdpa_id"].to_i, name: row["pa_name"])
          pa.designation = Designation.find_or_create_by(name: row["designation"])
          pa.designation.designation_type = DesignationType.find_or_create_by(name: row["designation_type"])
          countries = row["countries"].split(',')
          countries.each do |country|
            pa.countries << Country.find_by_iso3(country)
          end
          pa.save
          id = pa.id
        end
        ProtectedAreasWdpaRelease.create(wdpa_release_id: wdpa_release.id, protected_area_id: id)
      end
    end
  end
end

roles = ["Admin", "Team"]
roles.each { |r| Role.where(name: r).first_or_create }

if Rails.env.development?
  user = User.find_or_initialize_by(email: "test@test.com", role: Role.find_by_name("admin"))
  user.password = user.password_confirmation = "test1234"
  user.save
end
