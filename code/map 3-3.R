library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package

# tm_shape(nz) +
#   tm_fill() 
# 
# tm_shape(nz) +
#   tm_borders() 
# 
# 
# tm_shape(nz) +
#   tm_fill() +
#   tm_borders() 


OH_map <- subset(states, states$state_abbr %in% c(
  "OH"
))

tm_shape(OH_map)+
  tm_fill() +
  tm_borders()
# 
# map_nz = tm_shape(nz) + tm_polygons()
# class(map_nz)


map_new_oh = tm_shape(OH_map) + tm_polygons()
class(map_new_oh)


# map_nz1 = map_nz +
#   tm_shape(nz_elev) + tm_raster(alpha = 0.7)
# 
# nz_water = st_union(nz) %>% st_buffer(22200) %>% 
#   st_cast(to = "LINESTRING")
# 
# map_nz2 = map_nz1 +
#   tm_shape(nz_water) + tm_lines()
# 
# map_nz2

tm_shape(nz) + tm_polygons(col = "Median_income")
tm_shape(OH_map) + tm_polygons(col = "reserve")
tm_shape(OH_map) + tm_polygons(col = "reserve", palette="BuGn")


tm_shape(states) + tm_polygons(col = "Reserve in US$")
 
# breaks = c(0, 3, 4, 5) * 10000
# tm_shape(nz) + tm_polygons(col = "Median_income", breaks = breaks)
# tm_shape(nz) + tm_polygons(col = "Median_income", n = 10)
# tm_shape(nz) + tm_polygons(col = "Median_income", palette = "BuGn")



tm_shape(OH_map) + tm_polygons(col = "reserve") + tm_style("col_blind")+ tm_layout(title = "Ohio Counties")
