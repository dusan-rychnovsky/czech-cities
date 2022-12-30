basic_info = File.readlines('db-wiki.csv').each_with_object({}) do |line, acc|
  next if line.strip!.empty?
  id, city, population, _, _ = line.split(',')
  next if id == "id"  
  acc[id] = { :city => city, :population => population.to_i }
end

File.readlines('db-gps.csv').each do |line|
  next if line.strip!.empty?
  id, lat, lon = line.split(',')
  next if id == "id"
  basic_info[id][:lat] = lat
  basic_info[id][:lon] = lon
end

def load_distances(filename)
  File.readlines(filename).each_with_object({}) do |line, acc|
    next if line.strip!.empty?
    id, _, time = line.split(',')
    next if id == "id"  
    acc[id] = { :time => time.to_f }
  end
end

distances_hranice = load_distances 'car-distances-hranice.csv'
distances_caslav = load_distances 'car-distances-caslav.csv'
distances_praha = load_distances 'car-distances-praha.csv'

def color(id, distances_hranice, distances_caslav)
  if distances_hranice[id][:time] <= 2 && distances_caslav[id][:time] <= 1.5
    "green"
  elsif distances_hranice[id][:time] <= 2
    "blue"
  elsif distances_caslav[id][:time] <= 1.5
    "yellow"
  else
    "gray"
  end
end

basic_info.each do |id, value|
  if value[:population] >= 5_000
    puts "\"#{value[:city]}\": [\"#{color id, distances_hranice, distances_caslav}\",#{value[:lat]},#{value[:lon]}],"
  end
end
