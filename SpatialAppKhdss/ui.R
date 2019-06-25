library(shiny)
library(shinythemes)
library(shinydashboard)


#cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, slate, spacelab, superhero, united, yeti.
#ui.R
# Define UI for random distribution application 
shinyUI(fluidPage(theme = shinytheme("spacelab"),
                  
              
  
  # Application title
  titlePanel("Spatial Distribution"),
  
  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      h3("1. Upload Data"),
      fileInput('file1', 'With Coordinates(.csv file)',
                accept=c('text/csv','text/comma-separated-values,text/plain','.csv')),
      tags$hr(),
      h3("2. Upload map (shapefile)"),
      
      fileInput('file2', 'Upload all map files at once: shp, dbf, shx and prj.',
                accept=c('.shp','.dbf','.sbn','.sbx','.shx',".prj"), multiple=TRUE)),
    mainPanel(
      plotOutput("mapPlot")
    )
  )))