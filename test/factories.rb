FactoryGirl.define do
  # Sequences
  ###########
  sequence :iso3 do |n|
    "CI#{n}"
  end

  # Factories
  ###########
  factory :wdpa_release do
    name "WDPA_May2016"

    valid_from DateTime.now
    valid_to   DateTime.now + 1
  end

  factory :country do
    iso3
    name "Civilization"
  end

  factory :designation_type do
    name "National"
  end

  factory :designation do
    name "National Park"
    designation_type
  end
end
