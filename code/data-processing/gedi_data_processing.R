# examine GEDI Data 

library(terra)
library(tidyverse)
library(ggspatial)
library(ggtext)

# copy over GEDI data

system("cp -r ~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/GEDI_L4B_Gridded_Biomass_V2_1 ~/GEDI_L4B_Gridded_Biomass_V2_1") #move the data first!!

# load ecoregion shape: 
soro_eco_sf <- st_read("~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/Team_outputs/Team5/output_data/southern_rockies_eco.shp")

# load gedi biomass
gedi_files <- list.files("~/GEDI_L4B_Gridded_Biomass_V2_1/GEDI_L4B_Gridded_Biomass_V2_1_2299/data", pattern = "*MU.tif$", full.names = TRUE)
gedi_rast <- terra::rast(gedi_files) # stick with aboveground biomass

plot(gedi_rast)

# transform ecoreg to spatvec and to epsg:6933
soro_eco_6933_vect <- soro_eco_sf %>% 
  st_transform(crs = "epsg:6933") %>%
  vect()

gedi_rast_crop <- terra::crop(gedi_rast, soro_eco_6933_vect)
gedi_rast_mask <- terra::mask(x = gedi_rast_crop, soro_eco_6933_vect)

# make a map of biomass 

ggplot() +
  tidyterra::geom_spatraster(data = gedi_rast_aea) +
  # geom_sf(data = st_as_sf(soro_eco_6933_vect), fill = NA, color = "black") +
  scale_fill_viridis_c(
    name = "Biomass (Mg ha<sup>-1</sup>)",
    limits = c(0, 250), na.value = "transparent") +
  theme_void() + 
  theme(legend.title = element_markdown()) +
  ggspatial::annotation_north_arrow(
    pad_y = unit(1, "cm"),
    which_north = "true"
  ) + 
  ggspatial::annotation_scale() 

ggsave("~/data-store/FCC24_Group_5/code/visualization/gedi_biomass_south_rock.png", units = "in", width = 6, height = 6)

plot(gedi_rast_mask)

# Filter by Elevation and Sum Total BViomass

# read in the elevation raster 
elev_rast <- rast("soro_elev.tif")

# project gedi data to elev raster
gedi_rast_aea <- project(gedi_rast_mask, elev_rast)

# filter to elevations above 9k feet and below 11.5k feet (2743.2m, 3505.2m)
elev_reclass <- clamp(elev_rast, lower = 2743.2, upper = 3505.2, values = FALSE)

gedi_rast_elev_aea <- mask(gedi_rast_aea, elev_reclass)

mgha_to_tot_bio <- function(x) {
  # total megagrams per cell 
  # hectares to km2 and divide by cell area (1.4 km2)
  # 100 hectares / km2 * 1.4 km2
  (x * 100) * 0.014
}

gedi_ab <- app(gedi_rast_elev_aea, mgha_to_tot_bio)
gedi_ab_soro <- app(gedi_rast_mask, function(x) x*100) 
gedi_ab_soro2 <- app(gedi_rast_aea, mgha_to_tot_bio)

sum(values(gedi_ab, na.rm = TRUE))/1000000  # megagrams to million metric tons 

sum(values(gedi_ab, na.rm = TRUE))/(1000000*2)  # megagrams to million metric tons and C stock
sum(values(gedi_ab_soro, na.rm = TRUE))/(1000000*2)  # megagrams to million metric tons and C stock
sum(values(gedi_ab_soro2, na.rm = TRUE))/(1000000*2)  # megagrams to million metric tons and C stock

# 345787216

plot(gedi_rast_elev_aea)

# make a map of the high elevation region
high_elev_bin <- ifel(is.na(elev_reclass), 0, 1)
high_elev_sf <- st_as_sf(
  as.polygons(high_elev_bin)
)

high_elev_sf <- high_elev_sf %>% 
  filter(fileab72750c79d == 1)

 

# Make Map

ggplot() +
  tidyterra::geom_spatraster(data = gedi_rast_aea) +
  geom_sf(data = high_elev_sf, fill = "grey", color = "white") +
  scale_fill_viridis_c(
    name = "Biomass (Mg ha<sup>-1</sup>)",
    limits = c(0, 250), na.value = "transparent") +
  theme_void() + 
  theme(legend.title = element_markdown()) +
  ggspatial::annotation_north_arrow(
    pad_y = unit(1, "cm"),
    which_north = "true"
  ) + 
  ggspatial::annotation_scale() 


# Bring in the wildfire data

fire_events_sf <- read_sf("southern_rockies_fire_events_stats.gpkg")
no_events_sf <- read_sf("southern_rockies_eventless.geojson")

colnames(fire_events_sf)

# filter events to fire between 2002 - 2005
# create categories for forest 
fire_events_sf <- fire_events_sf %>% 
  filter(between(Year, 2002, 2005)) 

fire_events_6933 <- st_transform(fire_events_sf, "epsg:6933")
high_elev_6933 <- st_transform(high_elev_sf, crs = "epsg:6933")


ggplot() +
  geom_sf(data = high_elev_6933, fill = "white") +
  geom_sf(data = fire_events_6933, fill = "red")

fire_events_high_elev <- fire_events_6933 %>% 
  st_filter(high_elev_6933, .pred = st_intersects)

no_events_high_elev <- no_events_sf %>% 
  st_transform(crs = "epsg:6933") %>%
  st_filter(high_elev_6933, .pred = st_intersects)

fire_events_high_elev_m <- fire_events_high_elev %>% 
  group_by(Event_Type) %>%
  st_union()

# create vectors
fire_events_high_elev_aea <- st_transform(fire_events_high_elev_m, crs = st_crs(gedi_ab_soro))
no_events_aea <- st_transform(no_events_high_elev, crs = st_crs(gedi_ab_soro))

fire_events_vec <- vect(fire_events_high_elev_aea)
no_events_vec <- vect(no_events_aea)

no_events_rast <- terra::rasterize(no_events_vec, gedi_ab_soro)

terra::zonal(x = gedi_ab_soro, fire_events_vec, fun = "sum", na.rm = TRUE)
terra::zonal(x = gedi_ab_soro, no_events_vec, fun = "sum", na.rm = TRUE)

# 52651.24 Mg 
# 5.265 million metric tons of C in fire areas

# 




ggplot() +
  tidyterra::geom_spatraster(data = gedi_rast_mask) + 
  geom_sf(data = fire_events_6933, fill ="red") 


