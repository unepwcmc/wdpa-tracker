require 'csv'
require 'test_helper'

class CsvImporterTest < ActiveSupport::TestCase
  CSV_CONTENT = [{wdpaid: "123", iso3: "CIV", desig_eng: "National Park", desig_type: "National"},
                 {wdpaid: "234", iso3: "CIV", desig_eng: "National Park", desig_type: "National"}]

  test "import(path, wdpa_release) creates protected areas with wdpa_id" do
    path = "tmp/uploaded.csv"
    wdpa_release = FactoryGirl.create(:wdpa_release)
    CSV.stubs(:foreach).multiple_yields([CSV_CONTENT[0]], [CSV_CONTENT[1]])

    CsvImporter.import(path, wdpa_release)

    assert ProtectedArea.find_by_wdpa_id(123), "pa with 123 not found"
    assert ProtectedArea.find_by_wdpa_id(234), "pa with 234 not found"
  end

  test "import(path, wdpa_release) creates protected areas with wdpa_release" do
    path = "tmp/uploaded.csv"
    wdpa_release = FactoryGirl.create(:wdpa_release)
    CSV.stubs(:foreach).multiple_yields([CSV_CONTENT[0]], [CSV_CONTENT[1]])

    CsvImporter.import(path, wdpa_release)

    assert_equal [wdpa_release], ProtectedArea.find_by_wdpa_id(123).wdpa_releases
    assert_equal [wdpa_release], ProtectedArea.find_by_wdpa_id(234).wdpa_releases
  end

  test "import(path, wdpa_release) creates protected areas with the country" do
    path = "tmp/uploaded.csv"
    country = FactoryGirl.create(:country, iso3: "CIV")
    wdpa_release = FactoryGirl.create(:wdpa_release)

    CSV.stubs(:foreach).multiple_yields([CSV_CONTENT[0]], [CSV_CONTENT[1]])

    CsvImporter.import(path, wdpa_release)

    assert_equal [country], ProtectedArea.find_by_wdpa_id(123).countries
    assert_equal [country], ProtectedArea.find_by_wdpa_id(234).countries
  end

  test "import(path, wdpa_release) creates protected areas with the designation" do
    path = "tmp/uploaded.csv"
    wdpa_release     = FactoryGirl.create(:wdpa_release)
    designation_type = FactoryGirl.create(:designation_type, name: "National")
    designation      = FactoryGirl.create(:designation, name: "National Park",
                                          designation_type: designation_type)

    CSV.stubs(:foreach).multiple_yields([CSV_CONTENT[0]], [CSV_CONTENT[1]])

    CsvImporter.import(path, wdpa_release)

    assert_equal designation, ProtectedArea.find_by_wdpa_id(123).designation
    assert_equal designation, ProtectedArea.find_by_wdpa_id(234).designation
  end
end

