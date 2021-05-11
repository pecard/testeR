## code to prepare `DATASET` dataset goes here
pacman::p_load(tidyverse, sf, readxl, here, janitor, RPostgreSQL )
e2p <- readxl::read_xlsx('./data-raw/e2p_eolicas_nacional.xlsx', sheet = 'e2p', skip = 6)
e2p <- clean_names(e2p)


rn2000 <- sf::read_sf('D:/Sig/Vetor/Conservacao/sitios/SIC_JUL_2014.shp')
usethis::use_data(rn2000, overwrite = TRUE)


#bird_track <- db_month[,c('date_l', 'track_id', 'speed', 'heading', 'altm')]
bird_track
usethis::use_data(bird_track, overwrite = TRUE)

# Tides for ecology analysis ----
tidepeak <- readRDS("D:/Dropbox/programacao/GtruthRadar/data/tidapeak_20_21.rds")
data.table::setDT(tidepeak)

tidepeak[, dateref := data ]
usethis::use_data(tidepeak, overwrite = TRUE)


adm0_pt <- sf::read_sf('D:/Google Drive/sig/bd_elementos_sig_projetos.gpkg', 'admin_limite_pt')

adm1_pt <- sf::read_sf('D:/Google Drive/sig/bd_elementos_sig_projetos.gpkg', 'admin_distrito')
adm1_pt <- adm1_pt[, 4]

plot(adm1_pt[, 4])
usethis::use_data(adm1_pt, overwrite = TRUE)

# For tile srtm_35_05 the link is
# https://drive.google.com/file/d/1qtfX3EgSOfhgNCF01TyfXkXSAmBWwLFO/view?usp=sharing
# Retain tile_ID pnly from the link above

tileID <- '1qtfX3EgSOfhgNCF01TyfXkXSAmBWwLFO'

# Install and load googledrive package
library(googledrive)
library(raster)
temp <- tempfile(fileext = ".zip")
# Download a ~20Mb zip file.
# In the process a wizard will guide you to work with the API (use your google account)
dl <- drive_download(
  as_id("1qtfX3EgSOfhgNCF01TyfXkXSAmBWwLFO"), path = temp, overwrite = TRUE)
# Unzip to a temp folder (~170Mb asc file)
out <- unzip(temp, exdir = tempdir())
# Read asc raster
tile1 <- raster(out[2])
plot(tile1)

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
