# Load all libraries

library(leaflet)
library(tidyverse)
library(ggplot2)
library(sf)
library(shiny)
library(withr)

# resources: https://stackoverflow.com/questions/5812493/how-to-add-leading-zeros

USA <- st_read(dsn = './data/county data/cb_2018_us_county_500k.shp')

auction_data <- read.csv("./data/5G auction results/county_status-filtered.csv",
                    stringsAsFactors = FALSE)

#pad the numbers on GeoID/census ID & rename
auction_data$census_id = with_options(c(scipen = 999), str_pad(auction_data$census_id, 5, pad = "0"))
auction_data <- auction_data %>% rename("GEOID" = census_id)

# create sf object from st 
states_sf <- st_as_sf(USA)


#left join
states_sf_5g <- left_join(states_sf, auction_data, by="GEOID")
states_sf_5g <- st_transform(states_sf_5g, 4326)  # reproject to 4326

# states_sf_5g <- states_sf_5g %>%
#   # group_by(country) %>%
#   mutate(
#     bin_lengths = cut(posted_price, quantile(posted_price, probs=seq(0,1,0.1), na.rm=TRUE))
#   ) %>%
#   ungroup()


#shiny app

ui <- fluidPage(
  leafletOutput("map", height = "100vh")
)

# bins_auction = list(states_sf_5g$bin_lengths)

server <- function(input, output, session){
  # bins_auction = c(1e+03,1.7e+03,3.4e+03,5.4e+03,8.5e+03,1.4e+04,2.1e+04,3.3e+04,5.7e+04,1.09e+05,5.21e+07)
  bins_auction = c(1e+03,3.4e+03,5.4e+03,8.5e+03,1.4e+04,2.1e+04,3.3e+04,5.7e+04,1.09e+05,5.21e+07)
  mypal <- colorBin("YlOrBr", domain = states_sf_5g$posted_price, bins = bins_auction )
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("OpenStreetMap.Mapnik")%>%
      setView(lat = 39.8283, lng = -98.5795, zoom = 4) %>%
      addPolygons(
        data = states_sf_5g,
        fillColor = ~mypal(states_sf_5g$posted_price),
        stroke = FALSE,
        smoothFactor = 0.2,
        fillOpacity = 0.7,
        popup = paste("<b>County:</b> ", states_sf_5g$county_name, "<br>",
                      "<i>Selling Price (in US $)</i>: ", states_sf_5g$posted_price, "<br>")) %>%
      addLegend(position = "bottomleft",
                pal = mypal,
                values = states_sf_5g$posted_price,
                title = "Selling Price, in USD",
                opacity = 0.7)
  })
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)


#convert to geojson
# install.packages("geojsonsf")
# 
# library(geojsonsf)
# export_file <- sf_geojson(states_sf_5g, atomise = T)
# 
# # reprojection
# states_sf_5g_transformed <- st_transform(states_sf_5g, 4326)
# st_crs(states_sf_5g_transformed) # confirmation on reprojection

