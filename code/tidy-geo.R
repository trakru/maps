library(tidyverse)
library(revgeo)
install.packages('tidygeocoder')



# load file
DA_20_823A2 <- read_csv("ess_payout_locations/data/DA-20-823A2.csv")

missing_df <- DA_20_823A2 %>% filter(is.na(`Site Zip Code`))


y = revgeo(missing_df$longitude[1], missing_df$latitude[1],provider='photon', output='frame')

y


y1 = revgeo(DA_20_823A2$longitude[10], DA_20_823A2$latitude[10],provider='photon')


y1 =revgeo(missing_df$longitude[1], missing_df$latitude[1],provider='photon', output='hash', item=c('county', 'zip'))

y1

y1[[1]][1]


y1[[1]]


revgeo(missing_df$longitude[140], missing_df$latitude[140],provider='photon', output='hash', item=c('county', 'zip', 'city'))
