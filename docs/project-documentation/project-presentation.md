# Presentation

To set the stage, enjoy these beautiful pictures of the high alpine Southern Rockies taken on the daring mountain bike adventures of Smaulder Squad member Ashley Woolman.
<p float="left">
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/IMG_0138.jpg" alt="drawing" width="250"/>
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/IMG_5108.jpg" alt="drawing" width="250"/>
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/IMG_5256.jpg" alt="drawing" width="250"/>
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/IMG_9651.JPG" alt="drawing" width="250"/>
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/original_6409622c-b99b-42ec-aff2-b0870d097180_PXL_20210815_181251343.jpg" alt="drawing" width="250"/>
</p>

## Background
### Context and Importance

High elevation subalpine forests of the southern Rocky Mountains span from 9,000-11,500 feet. Forest types within this elevation gradient include lodgepole pine, Engelmann spruce, subalpine fir, and sometimes quaking aspen. These forests transition to treeless alpine tundra at the highest elevations (over 11,500 feet). 

These forests grow in very harsh conditions but are rather simple in composition and annual productivity is low. 
Common disturbances in lodgepole pine forests are mountain pine beetles and dwarf mistletoe. Spruce beetles and western spruce budworm impact Engelmann spruce/subalpine fir trees. 

Subalpine forests infrequently burn. The return interval for naturally occurring fires can vary in these forest types. Spruce/fir forests historically are ~300 years, while lodgepole pine can be 150-400 years and require fire to regenerate. 

While disturbances have always been a part of subalpine forest ecology in the southern Rocky Mountains, we know that beetle and wildfire outbreaks have increased, causing widespread tree mortality, affecting forest ecosystem services, and altering forest carbon dynamics. 

### Gap in Knowledge

The effects of disturbances (fire, insect and disease outbreaks) on the trajectories of carbon recovery in subalpine forests are not fully understood. This includes how different types of disturbances might alter aboveground carbon storage capacity and the speed of vegetation recovery. Further, there is much variability among subalpine forest types, each with unique species compositions and structural characteristics. Identifying these differences is important for effective forest management and restoration strategies, climate change mitigation and adaptation, understanding carbon budget estimates, and informing policy decisions. 


## Research Questions

1. How much land burned from 2002-2005 within our area of interest and study period? And similarly, within our area of interest, how much land has not seen any disturbances (as classified by Landfire)?

2. Within the subalpine forests of the southern Rocky Mountains (9,000-11,500 feet in elevation), how does aboveground carbon differ in areas that burned between 2002-2005 and did have not undergone a disturbance from 1999-2020?


## Methods 

We utilized five data sources: [EPA L3 Southern Rockies ECO Regions](), [OpenTopography Elevation](https://github.com/jhollist/elevatr), [National Land Cover Database](), [Provided LandFire](), [GEDI L4 Gridded Biomass]().

1. Identify area of interest: EPA’s Level 3 Southern Rockies Ecoregion
<figure>
  <img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/method_image1.png" alt="Map 1" width="500">
  <figcaption>Map 1: Southern Rockies.</figcaption>
</figure>
</br>

2. Within our ecoregion, identify subalpine forests including spruce-fir/lodgepole pine, and aspen
a. Filtered for 9,000-11,500 feet in elevation
b. Used NLCD land cover types

| Map 2 | Map 3|
|:---|:---|
|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/method_image2.png" alt="Map 2"><figcaption>Elevation map of Southern Rockies.</figcaption></figure>|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/method_image3.png" alt="Map 3"><figcaption>Land cover map of Southern Rockies.</figcaption></figure>|

3. Identify disturbed areas (wildfire) and undisturbed within last 25 years 
a. Areas which burned in a wildfire between 2002-2005
b. Areas with no disturbance between 1999-2020

| Map 4 | Map 5 |
|:----:|:----:|
|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/method_image4.png" alt="Map 4"><figcaption>red = fire events 2002-2005, blue = 2005-2020 fires.</figcaption></figure>|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/docs/project-documentation/method_image5.png" alt="Map 5"><figcaption>gray = no disturbance.</figcaption></figure>|

## Results

| Map 6 | Map 7 |
|:----:|:----:|
|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/code/visualization/gedi_biomass_south_rock.png" alt="Map 6"><figcaption>Southern Rockies GEDI biomass estimate between 2019-2023.</figcaption></figure>|<figure><img src="https://raw.githubusercontent.com/CU-ESIIL/FCC24_Group_5/main/code/visualization/gedi_biomass_highelev_fire_32613.png" alt="Map 7"><figcaption>Southern Rockies GEDI biomass with target high elevation fire events.</figcaption></figure>|

Table 1: Land area ($km^2$) that burned between 2002-2005 and underwent no disturbance during out study period within the Southern Rockies Ecoregion.

| | Area $km^2$ | Carbon $TMT/km^2$ |
|:----|:----:|:----:|
| Burned 2002-2005 | 1233.56 | 2.67 |
| No disturbance during study period | 122,704.31 | 3.30 |

## Conclusions

We combined datasets with disturbance events, landcover types, and biomass to compare
biomass and carbon differences in disturbed and undisturbed areas of high-elevation forests in the Southern Rockies. We found that undisturbed regions had higher $C/km^2$ than burned regions, though burned regions experienced significant recovery of C stocks.

Future steps we would take would include:
  - separating out forest types to examine C recovery in deciduous, evergreen, and mixed forest types
  - compare additional disturbance events to see how C recovery changes through time in different forest types
  - examine NPP/GPP changes over time in high-elevation forests
  - look at multiple disturbance types
