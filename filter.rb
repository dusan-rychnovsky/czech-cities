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

basic_info.each do |id, value|
  if value[:population] >= 10_000
    if distances_hranice[id][:time] <= 2.5 && distances_caslav[id][:time] <= 2
      puts "\"#{value[:city]}\": [\"red\",#{value[:lat]},#{value[:lon]}],"
    else
      puts "\"#{value[:city]}\": [\"blue\",#{value[:lat]},#{value[:lon]}],"
    end
  end
end
