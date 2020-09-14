install.packages("rgdal")
install.packages("spdplyr")
install.packages("geojsonio")
install.packages("rmapshaper")

library(rgdal)
library(leaflet)

states <- readOGR("C:/Users/thetr/Downloads/Auction_904_Updated_Eligible_Areas/Auction_904_Updated_Eligible_Areas.shp",
                  GDAL1_integer64_policy = TRUE)

neStates <- subset(states, states$state_abbr %in% c(
  "CT","ME","MA","NH","RI","VT","NY","NJ","PA"
))


leaflet(neStates) %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              # fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))
