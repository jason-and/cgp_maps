library(httr)
library(sf)
library(leaflet)

url <- parse_url("https://gis.cookcountyil.gov/traditional/rest/services/politicalBoundary/MapServer/9")

url$query <- list(outFields = "*",
                  returnGeometry = "true",
                  f = "geojson",
                  where = "1=1")

request <- build_url(url)

districts <- read_sf(request)
