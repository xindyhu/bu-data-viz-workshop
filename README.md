# BU SPH Data Viz Workshop, 2023

Code repository for the data visualization workshop at BU SPH, August 2023

Content will be provided before August 17th. Check back later!

# Set up

1. Install R and RStudio from https://posit.co/download/rstudio-desktop/
2. Open bu-datat-viz-workshop.Rproj in RStudio
3. Install `renv` if you don't already have it
4. Run `renv::restore()` to load dependencies
5. Click on the "Run App" button in RStudio when you've opened both the ui.R and server.R files

# Files in this folder

- [`global.R`](global.R)
  - Utility: load packages and read in data to render the visualizations
- [`ui.R`](ui.R)
  - Utility: design the front end of a Shiny app.
- [`server.R`](server.R)
  - Utility: where the work of the Shiny app is done, where R code is evaluated and output is generated that is then sent to the ui.R file to be displayed to the user.
- [`www`](www)
  - Utility: contains a CSS file, which describes how HTML elements should be displayed
- ['data`](data)
  - Utility: contains data files needed for the visualization

