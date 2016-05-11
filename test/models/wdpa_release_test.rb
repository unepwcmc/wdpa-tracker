require 'test_helper'

class WdpaReleaseTest < ActiveSupport::TestCase
  test "valid_on(datetime) returns the WdpaRelease valid in the interval" do
    release_2015 = WdpaRelease.create(name: "WDPA_2015", valid_from: DateTime.new(2015), valid_to: DateTime.new(2016))
    release_2016 = WdpaRelease.create(name: "WDPA_2016", valid_from: DateTime.new(2016), valid_to: DateTime.new(2017))

    assert_equal release_2015, WdpaRelease.valid_on(DateTime.new(2015, 1, 1))
    assert_equal release_2015, WdpaRelease.valid_on(DateTime.new(2015, 12, 31, 23, 59, 59))

    assert_equal release_2016, WdpaRelease.valid_on(DateTime.new(2016, 1, 1, 0, 0, 0))
    refute_equal release_2016, WdpaRelease.valid_on(DateTime.new(2017, 1, 1, 0, 0, 0))
  end

  test "valid_on?(datetime) returns true if the release is valid on given datetime" do
    release_2015 = WdpaRelease.create(name: "WDPA_2015", valid_from: DateTime.new(2015), valid_to: DateTime.new(2016))
    release_2016 = WdpaRelease.create(name: "WDPA_2016", valid_from: DateTime.new(2016), valid_to: DateTime.new(2017))

    assert release_2015.valid_on?(DateTime.new(2015, 2, 3))
    refute release_2016.valid_on?(DateTime.new(2015, 2, 3))
  end
end
