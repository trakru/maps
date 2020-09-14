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

saveRDS(states_sf_5g, file = "./data/states_sf_5g.RData")
