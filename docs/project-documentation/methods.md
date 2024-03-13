# Project methods overview

## Data Sources
List and describe data sources used, including links to cloud-optimized sources. Highlight permissions and compliance with data ownership guidelines.

- [National Land Cover Database (NLCD)](https://www.usgs.gov/centers/eros/science/national-land-cover-database) by the USGS, with data from 2001-2019 updated every 2 or 3 years, this is the "the definitive land cover database for the United States." We are using the "Land Cover" map product – Conterminous U.S. land cover at a 30-meter spatial resolution with a 16-class legend based on a modified Anderson Level II classification system . This dataset is used to get ecosystem diagnostics.

- [Level IV Ecoregions data](https://www.epa.gov/eco-research/ecoregions) from the EPA, who defines ecoregions as "areas where ecosystems (and the type, quality, and quantity of environmental resources) are generally similar." Level IV data has a granularity of 967 ecoregions in the conterminous U.S. We use this dataset to define the Southern Rocky region.

![](https://www.epa.gov/sites/default/files/2015-11/eco_level_iv_us_sm.gif)

- [Landfire (LF)](https://www.landfire.gov/) data is used to quantify oiur disturbance type. The LF program contains 25+ geo-spatial layers, including disturbance dates and types. We are subsetting for wildfire disturbance events. This data exists from 1999-2005.

- [Global Ecosystem Dynamics Investigation (GEDI)](https://gedi.umd.edu/) from the University of Maryland is an project that uses LIDAR from the International Space Station to profile ecosystems by ranging Earth's forests and topography. This dataset contains tree cover and canopy height variables which we will use to make our Carbon-related estimates before and after disturbance events.
   
## Data Processing Steps
Describe data processing steps taken, the order of scripts, etc.

## Data Analysis
Describe steps taken to analyze data and resulting files in team data store file structure.

## Visualizations
Describe visualizations created and any specialized techniques or libraries that users should be aware of.

## Conclusions
Summary of the full workflow and its outcomes. Reflect on the methods used.

## References
Citations of tools, data sources, and other references used.
