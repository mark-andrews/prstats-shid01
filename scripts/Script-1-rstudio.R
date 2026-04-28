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
  sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
  sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
  sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
  sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15),
  plotOutput("histogram")
)

server <- function(input, output){
  output$histogram <- renderPlot(
    {
      data_df <- tibble(x = rnorm(n = input$n, mean = input$mean, sd = input$sd))    
      ggplot(data_df, aes(x = x)) + 
        geom_histogram(bins = input$bins, color = 'white') + 
        theme_classic()
    }
  )  
}

shinyApp(ui, server)

# Select from dropdown ----------------------------------------------------

ui <- fluidPage(
  selectInput("distribution", "Select a probability distribution",
              choices = c("Normal" = "norm",
                          "Exponential" = "exp",
                          "Uniform" = "unif")),
  plotOutput("histogram")
)

server <- function(input, output){
  output$histogram <- renderPlot(
    {
      
      x <- switch(input$distribution, 
                  norm = rnorm(500),
                  exp = rexp(500),
                  unif = runif(500))
      
      data_df <- tibble(x = x)
      ggplot(data_df, aes(x = x)) + 
        geom_histogram(bins = 50, color = 'white') + 
        theme_classic()
    }
  )  
}

shinyApp(ui, server)

