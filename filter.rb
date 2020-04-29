File.open('db.csv').each do |line|
  next if line.strip!.empty?
  id, city, population, area, district, lat, lon, distance_from_hranice, distance_from_caslav = line.split(',')
  next if id == "id"

  population = population.to_i
  distance_from_caslav = distance_from_caslav.to_i
  distance_from_hranice = distance_from_hranice.to_i

  if population >= 10_000
    if distance_from_caslav <= 100
      if distance_from_hranice <= 155
        puts "#{city},#{district},#{distance_from_hranice},#{distance_from_caslav}"
      end
    end
  end
end
