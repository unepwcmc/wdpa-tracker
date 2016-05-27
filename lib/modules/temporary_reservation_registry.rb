module TemporaryReservationRegistry
  def self.put(wdpa_ids)
    Sidekiq.redis do |redis|
      redis.multi

      wdpa_ids.each { |id|
        redis.set("reserved:temporary:#{id}", id)
        redis.expire("reserved:temporary:#{id}", 3.minutes.to_i)
      }

      redis.exec
    end
  end

  def self.get(wdpa_ids)
    Sidekiq.redis do |redis|
      redis.multi
      wdpa_ids.each { |id| redis.get("reserved:temporary:#{id}") }
      redis.exec
    end.compact.map(&:to_i)
  end
end
