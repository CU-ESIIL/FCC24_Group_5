# Project methods overview

## Data Sources
List and describe data sources used, including links to cloud-optimized sources. Highlight permissions and compliance with data ownership guidelines.

- [National Land Cover Database (NLCD)](https://www.usgs.gov/centers/eros/science/national-land-cover-database) by the USGS, with data from 2001-2019 updated every 2 or 3 years, this is the "the definitive land cover database for the United States." We are using the "Land Cover" map product – Conterminous U.S. land cover at a 30-meter spatial resolution with a 16-class legend based on a modified Anderson Level II classification system . This dataset is used to get ecosystem diagnostics.

- [Level IV Ecoregions data](https://www.epa.gov/eco-research/ecoregions) from the EPA, who defines ecoregions as "areas where ecosystems (and the type, quality, and quantity of environmental resources) are generally similar." Level IV data has a granularity of 967 ecoregions in the conterminous U.S. We use this dataset to define the Southern Rocky region.

![](https://www.epa.gov/sites/default/files/2015-11/eco_level_iv_us_sm.gif)

- [Landfire (LF)](https://www.landfire.gov/) data is used to quantify oiur disturbance type. The LF program contains 25+ geo-spatial layers, including disturbance dates and types. We are subsetting for wildfire disturbance events. This data exists from 1999-2005.

- [Global Ecosystem Dynamics Investigation (GEDI)](https://gedi.umd.edu/) from the University of Maryland is an project that uses LIDAR from the International Space Station to profile ecosystems by ranging Earth's forests and topography. The L4 dataset contains gap-filled tree cover and canopy height variables which we will use to make our Carbon-related estimates before and after disturbance events. This data is only available between 2019 and 2023.

- The R package [`elevatr`](https://cran.r-project.org/web/packages/elevatr/index.html) is used to support terra elevation products from 3 sources: [Amazon Web Services Terrain Tiles](https://registry.opendata.aws/terrain-tiles), [Open Topography Global Datasets API](https://opentopography.org/developers), and [USGS Elevation Point Query Service](https://apps.nationalmap.gov/epqs). Elevation data is used to subset our forest to the high-alpine region.

- NASA's [Moderate Resolution Imaging Spectroradiometer (MODIS)](https://modis.gsfc.nasa.gov/data/dataprod/mod12.php) satellite provides us with percent land cover information. 🛰️
   
## Data Processing Steps
Describe data processing steps taken, the order of scripts, etc.

Once we've gathered our data, the processing steps are to:

1. Filter the NLCD polygons by the Southern Rocky region shapefile profided by the EPA Ecoregions.

2. Merge NLCD polygons into disruption categories. We will identify areas that experienced a single disturbance events of either insects or fires and areas that experienced no disturbance events. Disturbance interactions are too complicated for this short hackathon time frame and are removed for now.

3. Filter our disruption polygon between 9K - 11.5K feet (the high alpine regions) based on our elevation data.

4. Reclassifythe NLCD land cover categories to cover types that meet our research objectives. We kept all forest categories as forested land cover: deciduous, evergreen, and mixed. All other land categories (barren, shrubland, herbaceous, wetland) were reclassified as nonforest. The land cover categories are characterized by the [Multi-Resolution Land Characteristics Consortium (MRCC)](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description). 

## Data Analysis
Describe steps taken to analyze data and resulting files in team data store file structure.

Once we have our single or zero disturbance type polygons for our high-alpine, Southern Rocky region, we need to:

1. Cross our data with GEDI for aboveground Carbon or biomass estimates.

2. Investigate carbon deltas from before and after each disruption event.

3. Investigate carbon delta variability with forest type.

## Visualizations
Describe visualizations created and any specialized techniques or libraries that users should be aware of.

## Conclusions
Summary of the full workflow and its outcomes. Reflect on the methods used.

## References
Citations of tools, data sources, and other references used.
