library(sf)
library(tidyverse)
library(lubridate)
library(leaflet)
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(here)

# read in data
df_fips <- readRDS(here::here("data/df_fips.RDS"))
# list of 51 states
states <- c('U.S.', unique(df_fips$state) %>% sort())
# read in county-year level heatwave data
county_year <- readRDS(here::here('data/county_year.RDS'))
# read in county shapefiles
county_shp <- readRDS(here::here('data/county_shp.RDS'))
# read in state outline
state_shp <- readRDS(here::here('data/state_shp.RDS'))
# US National Atlas Equal Area projection
epsg2163 <- leafletCRS(
  crsClass = "L.Proj.CRS",
  code = "EPSG:2163",
  proj4def = "+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs",
  resolutions = 2^(16:7) 
)

# map color palettes
map_pal <- colorFactor(
  c("#ffffb2", "#fecc5c", "#fd8d3c", '#f03b20', "#bd0026"), 
  domain = levels(county_year$n_epis_bin), 
  ordered = TRUE
)

# map tooltip label
map_label_format <- function(county, n_epi, dur_epi) { 
  sprintf("<b>%s</b><br/>Heatwave (HW) episodes: %s </sup>
  <br/>Avg HW duration: %s days </sup>", 
          county, 
          n_epi, 
          if_else(n_epi==0, 0, round(dur_epi,1))) %>% 
    lapply(htmltools::HTML)
}
