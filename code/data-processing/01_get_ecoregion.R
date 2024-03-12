# get US L3 ecoregion for rockies

require(glue)
require(sf)
require(tidyverse)

epa_l3 <- glue::glue(
  "/vsizip/vsicurl/", #magic remote connection
  "https://gaftp.epa.gov/EPADataCommons/ORD/Ecoregions/us/us_eco_l3.zip", #copied link to download location
  "/us_eco_l3.shp") |> #path inside zip file
  sf::st_read()

soro_eco_sf <- filter(epa_l3, US_L3NAME == "Southern Rockies")

ggplot() + 
  geom_sf(data = soro_eco_sf) +
  theme_bw()

