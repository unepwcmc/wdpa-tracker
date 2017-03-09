require 'test_helper'

class ProtectedAreaTest < ActiveSupport::TestCase
  test "#present_intervals returns an array of couples of dates in which the PA was present in WDPA releases" do
    pa = ProtectedArea.create(name: "San Guillermo", wdpa_id: 10)

    release1 = WdpaRelease.create(name: "Jan 2001", created_at: DateTime.new(2001))
    _release2 = WdpaRelease.create(name: "Jan 2002", created_at: DateTime.new(2002))
    release3 = WdpaRelease.create(name: "Jan 2004", created_at: DateTime.new(2004))
    _release4 = WdpaRelease.create(name: "Jan 2010", created_at: DateTime.new(2010))
    release5 = WdpaRelease.create(name: "Jan 2015", created_at: DateTime.new(2015))

    pa.wdpa_releases = [release1, release3, release5]

    assert_equal pa.present_intervals, [
      [DateTime.new(2001), DateTime.new(2002)],
      [DateTime.new(2004), DateTime.new(2010)],
      [DateTime.new(2015)]
    ]
  end
end
