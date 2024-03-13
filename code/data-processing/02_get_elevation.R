# Get elevation data 

library(elevatr)

# load shapefile
soro_eco_sf <- st_read("~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/Team_outputs/Team5/output_data/southern_rockies_eco.shp")

soro_elev_rast <- get_elev_raster(soro_eco_sf, z = 11)

soro_elev_sr <- rast(soro_elev_rast)

plot(soro_elev_sr)

# write to local instance
terra::writeRaster(
  soro_elev_sr, 
  "~/soro_elev.tif",
  overwrite = TRUE
)

# copy to team output folder
system("cp ~/soro_elev.tif ~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/Team_outputs/Team5/output_data/")

# test 
soro_elev_test <- rast("~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/Team_outputs/Team5/output_data/soro_elev.tif")

plot(soro_elev_test)

ggplot() +
  tidyterra::geom_spatraster(data = soro_elev_sr) +
  geom_sf(data = soro_eco_sf, fill = NA, color = "white")

