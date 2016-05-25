require 'test_helper'

class ReservationServiceTest < ActiveSupport::TestCase
  test "reserve(from, to) creates pas with status 'reserved'" do
    from, to = [1, 10]
    ReservationService.reserve(from, to)

    assert_equal 10, ProtectedArea.count
    assert_equal (1..10).to_a, ProtectedArea.order(:wdpa_id).pluck(:wdpa_id)

    assert ProtectedArea.all.all? { |pa| pa.status == "reserved" }
  end

  test "reserve(from, to) raises if the range is not empty" do
    ProtectedArea.create(wdpa_id: 4)

    assert_raise(ReservationService::RangeNotEmptyError) do
      from, to = [1, 10]
      ReservationService.reserve(from, to)
    end
  end

  test "request(amount) returns an array of available WDPAIDs" do
    (1..10).each  { |wdpa_id| ProtectedArea.create(wdpa_id: wdpa_id) }
    (15..20).each { |wdpa_id| ProtectedArea.create(wdpa_id: wdpa_id) }
    (30..50).each { |wdpa_id| ProtectedArea.create(wdpa_id: wdpa_id) }

    expected = [11, 12, 13, 14,
                21, 22, 23, 24, 25, 26, 27, 28, 29,
                51, 52, 53, 54, 55, 56, 57]
    assert_equal expected, ReservationService.request(20)
  end
end
