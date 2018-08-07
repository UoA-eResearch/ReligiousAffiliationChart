server <- function(input, output) {
  
  dat <- read.csv("Data.csv")
  dat <- format(dat, digits = 3)
  age <- dat$age
  
  
  output$chart <- renderHighchart({
    
    chartData <- switch(input$radio,
                        "deconverting" = list(NULL, dat$deconversion),
                        "converting" = list(dat$conversion, NULL),
                        "converting and deconverting" = list(dat$conversion,dat$deconversion)
                        
    )
    
    
    hc <- highchart() %>%
      hc_title(text = paste(c("Probability of ", input$radio, " during lifespan"), collapse = ""),
               margin = 20, align = "center",
               style = list(color = "#000066", useHTML = FALSE)) %>% 
      hc_xAxis(title = list(text = "Age"),
                   categories = c(dat$age),
                   tickmarkPlacement = "on",
                   opposite = TRUE)
      
    
    if(is.null(chartData[[2]])){
      hc <- hc %>%
        hc_yAxis(title = list(text = "Probability of Converting to Religion"),
                 tickPositions = c(0.000, 0.025, 0.050, 0.075, 0.100),
                 allowDecimals = TRUE) %>%
        hc_add_series(data = c(as.numeric(chartData[[1]])),
                      type = "line",
                      name = "Conversion",
                      showInLegend = TRUE) %>%
        hc_colors(c("#009900", "#cc0000"))
    }
    
    else if(is.null(chartData[[1]])){
      hc <- hc %>%
        hc_yAxis(title = list(text = "Probability of De-converting from Religion"),
                 tickPositions = c(0.000, 0.025, 0.050, 0.075, 0.100),
                 allowDecimals = TRUE) %>%
        hc_add_series(data = c(as.numeric(chartData[[2]])),
                      type = "line",
                      name = "Deconversion",
                      showInLegend = TRUE) %>%
        hc_colors(c("#cc0000", "#009900"))
    }
    
    else{
      hc <- hc %>%
        hc_yAxis(title = list(text = "Lifespan Probability of Changing Religious Affiliation"),
                 tickPositions = c(0.000, 0.025, 0.050, 0.075, 0.100),
                 allowDecimals = TRUE) %>%
        hc_add_series(data = c(as.numeric(chartData[[1]])),
                      type = "line",
                      name = "Conversion",
                      showInLegend = TRUE) %>%
        hc_add_series(data = c(as.numeric(chartData[[2]])),
                      type = "line",
                      name = "Deconversion",
                      showInLegend = TRUE) %>%
        hc_colors(c("#009900", "#cc0000"))
    }
    
    hc <- hc %>%
      hc_add_theme(hc_theme_economist()) %>%
      hc_tooltip(valueDecimals = 3,
                 pointFormat = "Probablility: {point.y}")
    
    hc
    
  })
  
}