R Language mini test
================

# Ecoa/Bioinsight recruitment test

Thank you for taking this test as part of the recruitment process.
Please read this content carefully. If you find any issue with the data
or critical question please contact with
<a href="mailto:paulo.c@bioinsight.pt" class="email">paulo.c@bioinsight.pt</a>.

## Preparation

We strongly suggest you to use the latest version of R and possibly
RStudio. Please let us know as soon as possible if this may be an issue
for you. You can install R from [CRAN](https://CRAN.R-project.org) and
Rstudio from [RStudio
website](https://www.rstudio.com/products/rstudio-desktop-pro/download-commercial/).

## Objectives

We’ve prepared two small tests for this recruitment process. The idea is
that you will build the best approach to the problem and answer to the
specific questions they propose. You will be asked to send us your
approach and the main outputs in a short data report by Friday 7th.
Remember that it will require a suite of packages: tidyverse, sf,
data.table here, scales, raster, ggplot, and its dependencies.

## Report Detail

Your report must include answers to the questions with a a short
description of your outputs (maps, figures or tables) as well as the
code used.

## Your presentation

You will prepare and present a 5 minutes talk with your achievements for
each test, focusing on the critical aspects of the proposed questions.
Add the details you may think will help to understand it. Be clear and
concise. You can use a R Markdown presentation, a Power Point
presentation or any other resource that best fits your needs.

## Test 1 - Wind Energy Production in Portugal

### Questions

-   Map the wind energy facilities in mainland Portugal regarding the
    country and district borders. Apply the appropriate legend and
    choose one aggregation level (legend) to wind energy facilities.
-   Map the wind facilities and and its distribution regarding elevation
    and protected areas.
-   Find the the appropriate theme for the digital elevation model.
-   What is the total national installed capacity (in GW)?
-   How facilities are distributed in relation to altitude? plot the
    attitudinal distribution and describe.
-   How it has grown since the first installed facility?
-   Are protected areas affected? Where and to which extent (number of
    Sites)?

### Challenge 1

Build an interactive map where one can query for each facility its name,
year of commissioning and installed capacity (using e2p data).

### Data

You will find the data to work in the \~.data/ folder.

| Data         | Description                                                    |
|--------------|----------------------------------------------------------------|
| e2p.rda      | Wind farm location with name, date, coordinates and production |
| adm0\_pt.rda | Administrative boundary of Portugal ( level 0 )                |
| adm1\_pt.rda | District boundaries ( level 1 )                                |
| rn2000.rda   | Natura 2000 Sites                                              |

## Test 2 - Bird movement and tide height

### Questions

-   Describe the number of bird movements/hour.
-   Describe mean flight height/hour.
-   Are there any differences between mean number of bird movements/hour
    if you distinguish day and night periods?
-   Are there any differences between mean flight altitude/hour if you
    distinguish day and night periods?

### Challenge 2

-   Describe the pattern of bird movement in relation to tide height and
    distance to next high tide.

Suggestion: retain the first observation of each bird movement to map
the distance for next high tide.

### Data

You will find the required data to work in the \~.data/ folder.

| Data            | Description                                                     |
|-----------------|-----------------------------------------------------------------|
| bird\_track.rda | track points of individual birds. Unique ID in column track\_id |
| tidepeak.rda    | 2020 and 2021 tide peak time and height for Lisbon port         |

#### Bird track data description

| Column    | Description                        |
|-----------|------------------------------------|
| date\_l   | datetime of every record           |
| track\_id | unique ID for a single movement    |
| speed     | ground speed for the record        |
| heading   | compass orientation for the record |
| altm      | altitude in meter for the record   |

This dataset is GPS-PPT like. Every line is a obtained position.
Individual movements are identified by a single unique ID \[track\_id\].
A few variables are available for every position but they can result a
NULL/NA (fail to record).

### Notes & Tips

-   Take care with projections. Data are provided in geographic (WGS84
    EPSG 4326) and projected reference systems (PT-TM06 EPSG 3763).

-   Remember to deal with NA values when summarising.

-   Use a raster elevation model to get elevation data from. We are not
    providing any DEM raster for this test. For SRTM DEM the tiles for
    Portugal are 35\_04 and 35\_05.

-   Remember that some questions will be easier to approach using
    data.table package (specially directional roll joins).

-   You may find it useful to programmatically download and read SRTM
    raster tiles directly from [this
    source](https://drive.google.com/drive/folders/17dnXkQKlF_fcqqETrHco5cVfF3R7kty0).

<!-- -->

    # Install and load packages
    library(googledrive)
    library(raster)

    temp <- tempfile(fileext = ".zip")

    # For tile srtm_35_05 the link is
    # https://drive.google.com/file/d/1qtfX3EgSOfhgNCF01TyfXkXSAmBWwLFO/view?usp=sharing
    # Retain tile_ID from the link above

    # Download a ~20Mb zip file. 
    # In the process a wizard will guide you to work with the API (use your Google account)
    dl <- drive_download(
      as_id("1qtfX3EgSOfhgNCF01TyfXkXSAmBWwLFO"), path = temp, overwrite = TRUE)

    # Unzip to a temp folder (~170Mb asc file)
    out <- unzip(temp, exdir = tempdir())

    # Read asc raster from temp folder
    tile1 <- raster(out[2])

    # Plot to check
    plot(tile1)

-   If running your analysis from Windows OS, you can import data
    directly from github repo with:

<!-- -->

    dat_url <- 'https://raw.githubusercontent.com/pecard/testeR/master/data/e2p.rda?raw=true'
    download.file(dat_url,"e2p", method="curl")
    load("e2p")
    e2p

Instead, you can simply download the data from the repository into a
local folder.
