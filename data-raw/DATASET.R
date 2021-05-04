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


plot(adm1_pt)
usethis::use_data(adm1_pt, overwrite = TRUE)


library(RPostgreSQL)
try(conn <- dbConnect(PostgreSQL(),
                      dbname = "postgres",
                      port = 5432,
                      user = "postgres",
                      password = "100874"))

con <- dbConnect(
  RPostgres::Postgres(),
  host = "localhost",
  dbname = "postgres",
  port = 5432,
  user = "postgres",
  password = "mysecretpassword"
)

st_read_db
