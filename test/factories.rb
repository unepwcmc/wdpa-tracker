FactoryGirl.define do
  # Sequences
  ###########
  sequence :iso3 do |n|
    if n >= 10
      "C#{n}"
    else
      "CI#{n}"
    end
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

  factory :protected_area do
    name "San Guillermo"
    designation

    transient do
      wdpa_releases_count 5
      countries_count 1
    end

    after(:create) do |protected_area, evaluator|
      create_list(:wdpa_release, evaluator.wdpa_releases_count, protected_areas: [protected_area])
      create_list(:country, evaluator.countries_count, protected_areas: [protected_area])
    end
  end
end
