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
