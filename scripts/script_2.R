library(shiny)
library(tidyverse)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("type", "Choose distribution",
                   choices = c("Normal", "Beta", "Binomial")
      ),
      uiOutput("params")
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output){
  
  output$params <- renderUI(
    {
      switch(input$type,
             Normal = tagList(
               sliderInput("p1", "Mean", min = 75, max = 125, value = 100),
               sliderInput("p2", "sd", min = 5, max = 50, value = 15),
             ),
             Beta = tagList(
               sliderInput("p1", "alpha", min = 0.001, max = 50, value = 2),
               sliderInput("p2", "beta", min = 0.001, max = 50, value = 2),
             ),
             Binomial = tagList(
               sliderInput("p1", "Sample size", min = 50, max = 100, value = 75),
               sliderInput("p2", "Probability", min = 0.0, max = 1.0, value = 0.5),
             )
      )
    }
  )
  
  output$hist <- renderPlot({
    req(input$p1, input$p2)
    samples <- switch(input$type,
                      Normal = rnorm(1000, mean = input$p1, sd = input$p2),
                      Beta = rbeta(1000, shape1 = input$p1, shape2 = input$p2),
                      Binomial = rbinom(1000, size = as.integer(input$p1), prob = input$p2)
    )
    data_df <- tibble(samples = samples)
    ggplot(data_df, aes(samples)) + geom_histogram(bins = 25) + theme_minimal()
    
  })
  
}

shinyApp(ui, server)

# Tabbed panels -----------------------------------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("variable", "Select a variable", choices = colnames(mtcars))
    ),
    mainPanel(
       tabsetPanel(
        tabPanel("Histogram", plotOutput("hist")),
        tabPanel("Summary", verbatimTextOutput('summary')),
        tabPanel("Data", tableOutput('table'))
      )     
    )
  )
)


server <- function(input, output){
  output$hist <- renderPlot({
    ggplot(mtcars, aes(x = .data[[input$variable]])) + geom_histogram(bins = 10)
  })
  
  output$summary <- renderPrint({
    summary(mtcars[[input$variable]])
  })
  
  output$table <- renderTable({
    mtcars[input$variable]
  }, rownames = TRUE)
}

shinyApp(ui, server)
