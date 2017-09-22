require "open-uri"
require "sqlite3"
def time_from_funky(s)
# \/Date(1454789758000+0100)\/
  r = s[6,10].to_i
  d = Time.at(r)
end

db = SQLite3::Database.new("data.db")
f = open("http://reis.ruter.no/ReisRest/RealTime/GetRealTimeData/3010021")
require "json"
begin
  while line = f.readline
    next unless line =~ /^\[/
    body = JSON.parse(line)
    body.each do |dep|
      line_no = dep["PublishedLineName"]
      scheduled_arrival = time_from_funky(dep["AimedArrivalTime"])
      expected_arrival = time_from_funky(dep["ExpectedArrivalTime"])
      delay = (expected_arrival - scheduled_arrival) / 60
      percent_full = dep["Extensions"]["OccupancyData"]["OccupancyPercentage"] rescue ""
      db.execute("insert into departures (line_no, scheduled_arrival, expected_arrival, percent_full) values(?,?,?,?)", [line_no, scheduled_arrival.to_i, expected_arrival.to_i, percent_full])
    end
  end
rescue EOFError
  puts  "Done"
end

# Linje   | Scheduled arrival   | Delay in minutes | % full
# Linje 5 | 26/02-2016 10:02:00 | 2                | 20
