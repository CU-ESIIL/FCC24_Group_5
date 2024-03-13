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
  tidyterra::geom_spatraster(data = gedi_rast_mask) +
  geom_sf(data = st_as_sf(soro_eco_6933_vect), fill = NA, color = "black") +
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

