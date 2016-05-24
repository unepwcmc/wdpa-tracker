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
end
