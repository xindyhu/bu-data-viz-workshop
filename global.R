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
# read in county-year level data
county_year <- readRDS(here::here('data/county_year.RDS'))
# access county shapefiles from tigris
counties_shp <- readRDS(here::here('data/counties_shp.RDS'))
# US National Atlas Equal Area projection
epsg2163 <- leafletCRS(
  crsClass = "L.Proj.CRS",
  code = "EPSG:2163",
  proj4def = "+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs",
  resolutions = 2^(16:7) 
)