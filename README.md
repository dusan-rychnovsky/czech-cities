db-wiki.csv - a list of Czech cities (incl. population and area) downloaded from Wikipedia (https://cs.wikipedia.org/wiki/Seznam_m%C4%9Bst_v_%C4%8Cesku_podle_po%C4%8Dtu_obyvatel)
db-gps.csv - GPS coordinates of Czech cities, calculated from db-wiki.csv via Nominatim with map-city-to-gps.rb
car-distances-*.csv - distances by car to each Czech city from Hranice/Caslav/Praha, calculated from db-gps.csv via SMap API with calculate-distances-by-car.html
filter-cities-by-car-distances.rb - groups cities according to distances from Caslav and Hranice
map.html - shows grouped cities on a map via SMap API
