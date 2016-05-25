module ReservationService
  class RangeNotEmptyError < RuntimeError; end

  def self.reserve(from, to)
    check_for_already_present(from, to)

    (from..to).each { |wdpa_id|
      ProtectedArea.create!(wdpa_id: wdpa_id, status: "reserved")
    }
  end

  TRY_BATCH_SIZE = 1000
  def self.request(amount)
    try_from = 1
    try_to   = TRY_BATCH_SIZE

    reserved = []
    while reserved.length < amount
      reserved.concat(
        get_unused_wdpa_ids(try_from, try_to, amount-reserved.length)
      )

      try_from += try_to+1
      try_to   += TRY_BATCH_SIZE
    end

    reserved
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

  def self.get_unused_wdpa_ids(from, to, amount)
    ActiveRecord::Base.connection.select_values("""
      SELECT s.i AS available_wdpaids
      FROM generate_series(#{from}, #{to}) s(i)
      LEFT OUTER JOIN protected_areas ON (protected_areas.wdpa_id = s.i)
      WHERE protected_areas.wdpa_id IS NULL
      LIMIT #{amount}
    """).map(&:to_i)
  end
end
