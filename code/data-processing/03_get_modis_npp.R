
install.packages('luna', repos='https://rspatial.r-universe.dev')
library(luna)

# get list of MODIS products

getProducts("^MOD17")

product <- "MOD17A3H" # yearly NPP/GPP 500m Sinusoidal grid
start <- "2001-01-01"
end <- "2023-12-31"

# load the shapefile for the southern rockies 
soro_eco_sf <- st_read("~/data-store/data/iplant/home/shared/earthlab/forest_carbon_codefest/Team_outputs/Team5/output_data/southern_rockies_eco.shp")

soro_eco_sr <- vect(soro_eco_sf)

# see what is available for this area
mf <- luna::getNASA(product, start, end, aoi = soro_eco_sr, version = "061", download = FALSE, username = user, password = pwd)


