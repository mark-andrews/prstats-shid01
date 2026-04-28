library(shiny)

ui <- fluidPage(
  p("Hello world")
)

server <- function(input, output) {}

shinyApp(ui, server)


# Real interactive webapp -------------------------------------------------

ui <- fluidPage(
  sliderInput("n", "The number of points", min = 10, max = 100, value = 55),
  plotOutput("scatter")
)

server <- function(input, output){
  output$scatter <- renderPlot(
  {
   x <- rnorm(input$n)
   y <- rnorm(input$n)
   plot(x, y)
  }
  )
}

shinyApp(ui, server)


# Histogram with 4 sliders ------------------------------------------------

library(tidyverse)

ui <- fluidPage(
  sliderInput("bins", "Number of histogram bins", min = 10, max = 100, value = 30),
  plotOutput("histogram")
)

server <- function(input, output){
  output$histogram <- renderPlot(
    {
      data_df <- tibble(x = rnorm(n = 100, mean = 100, sd = 15))    
      ggplot(data_df, aes(x = x)) + 
        geom_histogram(bins = input$bins)
    }
  )  
}

shinyApp(ui, server)
