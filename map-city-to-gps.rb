require 'curb'
require 'json'

def fetch_gps_coords(city, district)
  city = CGI.escape(city)
  district = CGI.escape(district)
  url = "https://nominatim.openstreetmap.org/search?format=json&country=czech%20republic&county=#{district}&city=#{city}"
  # puts url
  response = Curl.get(url) do |req|
    req.headers['User-Agent'] = 'Dusan Rychnovsky'
  end
  json = JSON.parse(response.body_str)
  return json[0]['lat'], json[0]['lon']
end

def silent_retry_with_backoff
  (1..5).each do |retryNo|
    begin
      yield
      return
    rescue
      sleep 3
    end
  end
  raise "Maximum number of retries exceeded!"
end

puts "id,lat,lon"
File.open('db-wiki.csv').each do |line|
  next if line.strip!.empty?
  id, city, population, area, district = line.split(',')
  next if id == "id"

  silent_retry_with_backoff do
    lat, lon = fetch_gps_coords city, district
    puts "#{id},#{lat},#{lon}"
  end
  
  sleep 3
end
