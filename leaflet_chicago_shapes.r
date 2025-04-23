library(leaflet)
library(htmlwidgets)
library(htmltools)
library(sf)

# URL to the GeoJSON file from Cook County Open Data Portal
url <- "https://hub-cookcountyil.opendata.arcgis.com/datasets/8eb3dca457cb46d7a2a0c96588c4016c_9.geojson"

# Download the file
download.file(url, "cook_county_districts.geojson", mode = "wb")

# Read the GeoJSON file
districts <- st_read("cook_county_districts.geojson")


pal <- colorNumeric("viridis", districts$DISTRICT_INT)

# Create the map with filter options
map <- leaflet(districts) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        # Add each district as a separate group
        addPolygons(
                group = ~DISTRICT_TXT, # Group by district name
                layerId = ~DISTRICT_TXT, # Layer ID for search
                fillColor = ~ pal(DISTRICT_INT),
                weight = 1,
                opacity = 1,
                color = "white",
                dashArray = "3",
                fillOpacity = 0.7,
                label = ~DISTRICT_TXT,
                popup = ~ paste0("<b>District: </b>", DISTRICT_TXT, "<br><b>Number: </b>", DISTRICT_INT)
        ) %>%
        # Add the layer control
        addLayersControl(
                overlayGroups = unique(districts$DISTRICT_TXT),
                options = layersControlOptions(collapsed = FALSE)
        )


# Save the map
htmlwidgets::saveWidget(map, "cook_county_districts_map.html", selfcontained = TRUE)
