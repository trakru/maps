library(sf)
library(raster)
library(dplyr)
library(spData)

states  = st_read(dsn = "C:/Users/thetr/Downloads/Auction_904_Updated_Eligible_Areas/Auction_904_Updated_Eligible_Areas.shp")

class(states)

