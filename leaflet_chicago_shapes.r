library(sf)
library(leaflet)

# URL to the GeoJSON file from Cook County Open Data Portal
url <- "https://hub-cookcountyil.opendata.arcgis.com/datasets/8eb3dca457cb46d7a2a0c96588c4016c_9.geojson"

# Download the file
download.file(url, "cook_county_districts.geojson", mode = "wb")

# Read the GeoJSON file
districts <- st_read("cook_county_districts.geojson")

# Check the output
print(head(districts))

# Create a map
map <- leaflet(districts) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(
                fillColor = ~ colorNumeric("viridis", DISTRICT_INT)(DISTRICT_INT),
                weight = 1,
                opacity = 1,
                color = "white",
                dashArray = "3",
                fillOpacity = 0.4,
                popup = ~ paste0("<b>District: </b>", DISTRICT_TXT)
        )

# Save the map to an HTML file
htmlwidgets::saveWidget(map, "cook_county-districts_map.html")

