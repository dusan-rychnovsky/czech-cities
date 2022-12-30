# Czech Cities

The `map.html` web page shows all Czech cities that satisfy certain criteria. Currently the criteria are as follows:

* population of at least 5 000 and
* within 2 hours (b car) from Hranice and
* wthin 1.5 hours (by car) from Čáslav.

## Recomputation

To recalculate the results, follow these steps.

1. Use `db-wiki.csv` as your input. It's a list of all Czech cities, incl. population and area, downloaded manually from [Wikipedia](https://cs.wikipedia.org/wiki/Seznam_m%C4%9Bst_v_%C4%8Cesku_podle_po%C4%8Dtu_obyvatel).

2. Use `map-cities-to-gps.rb` to fetch GPS coordinates from [Nominatim API](https://nominatim.org/).

3. Use `calculate-distances-by-car.html` to calculate distances by car via [SMap API](https://api.mapy.cz/doc/SMap.html).

4. Use `filter-cities.rb` to filter the list.

