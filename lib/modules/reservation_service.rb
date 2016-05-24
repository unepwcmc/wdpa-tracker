module ReservationService
  class RangeNotEmptyError < RuntimeError; end

  def self.reserve(from, to)
    check_for_already_present(from, to)

    (from..to).each { |wdpa_id|
      ProtectedArea.create!(wdpa_id: wdpa_id, status: "reserved")
    }
  end

  def self.check_for_already_present(from, to)
    already_present = ProtectedArea.where(wdpa_id: from..to).pluck(:wdpa_id)

    if already_present.any?
      raise RangeNotEmptyError, """
        Reservation failed from #{from} to #{to}.
        These WDPAIDs are already present: #{already_present.inspect}
      """
    end
  end
end
