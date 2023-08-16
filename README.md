# BU SPH Data Viz Workshop, 2023

Code repository for the data visualization workshop at BU SPH, August 2023

# Set up

1. Install R and RStudio from https://posit.co/download/rstudio-desktop/
2a. If you use Mac, open a terminal, put in `gcc --version` to check if you have gcc installed. If not, follow tutorials [here](https://devicetests.com/fix-gcc-command-not-found-error-ubuntu) to install gcc.
2b. If you use Windows, make sure you install Rtools corresponding to your R version, follow tutorials [here](https://cran.r-project.org/bin/windows/Rtools/rtools43/rtools.html)
3. Open bu-datat-viz-workshop.Rproj in RStudio
4. Install `renv` if you don't already have it
5. Run `renv::restore()` to load dependencies
6. Click on the "Run App" button in RStudio when you've opened both the ui.R and server.R files

# Files in this folder

- [`global.R`](global.R)
  - Utility: load packages and read in data to render the visualizations
- [`ui.R`](ui.R)
  - Utility: design the front end of a Shiny app.
- [`server.R`](server.R)
  - Utility: where the work of the Shiny app is done, where R code is evaluated and output is generated that is then sent to the ui.R file to be displayed to the user.
- [`www`](www)
  - Utility: contains a CSS file, which describes how HTML elements should be displayed
- [`data`](data)
  - [`county_shp.RDS`](data/county_shp.RDS)
    - Utility: contains county shapefile for 50 states + DC
  - [`state_shp.RDS`](data/state_shp.RDS)
    - Utility: contains state shapefile for 50 states + DC
  - [`county_year.RDS`](data/county_year.RDS)
    - Utility: contains county-year level data of heatwaves
  - [`df_fips.RDS`](data/df_fips.RDS)
    - Utility: contains list of FIPS code, county and state names

