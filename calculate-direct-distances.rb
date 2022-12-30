# https://stackoverflow.com/questions/365826/calculate-distance-between-2-gps-coordinates

Coords = Struct.new(:lat, :lon)
hranice = Coords.new(49.548233, 17.7346535)
caslav = Coords.new(49.9109171, 15.3913205)

def to_radians(degrees)
  degrees * Math::PI / 180
end

def distance(first, second)
  dlat = to_radians(first.lat - second.lat)
  dlon = to_radians(first.lon - second.lon)
  lat1 = to_radians(first.lat)
  lat2 = to_radians(second.lat)

  a = Math.sin(dlat / 2) * Math.sin(dlat / 2) + Math.sin(dlon / 2) * Math.sin(dlon / 2) * Math.cos(lat1) * Math.cos(lat2)
  c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

  earth_radius_km = 6371
  earth_radius_km * c
end

File.open('db.csv').each do |line|
  next if line.strip!.empty?
  id, city, population, area, district, lat, lon = line.split(',')
  next if id == "id"

  coords = Coords.new(lat.to_f, lon.to_f)
  distance_from_hranice = distance(hranice, coords).ceil
  distance_from_caslav = distance(caslav, coords).ceil

  puts "#{line},#{distance_from_hranice},#{distance_from_caslav}"
end
