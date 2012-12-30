class Dtime
  def self.current_dtime
    seconds_today * 1000 / 864
  end

  def self.current_dtime_formatted
    dtime = self.current_dtime
    s =  dtime % 100
    m = (dtime / 100) % 10
    h = (dtime - (m + s)) / 1000
    "#{"%02d" % h}:#{m}:#{"%02d" % s}"
  end

  def self.current_dtime_formatted_hours_only
    dtime = self.current_dtime
    s =  dtime % 100
    m = (dtime / 100) % 10
    h = (dtime - (m + s)) / 1000
    "%02d" % h
  end

private

  def self.seconds_today
    now = Time.now
    now.to_i - Time.local(now.year, now.month, now.day, 0).to_i
  end

end

