library(shiny)
library(plotly)
library(highcharter)


ui <- fluidPage(
  titlePanel("Religious Affiliation"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("radio", label = h3("Select Data"),
                   choices = list("deconverting", "converting", "converting and deconverting"), selected = "converting and deconverting")
      
    ), 
    
    mainPanel(
      highchartOutput("chart", height = "100%", width = "80%")
    )
  )
)
