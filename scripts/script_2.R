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



# Selecting rectangles with the brush -------------------------------------

ui <- fluidPage(
  fluidRow(
    column(8, plotOutput("scatter", brush = 'brush')),
    column(4, tableOutput("table"))
  )
)

server <- function(input, output){
  output$scatter <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point(colour = 'steelblue', size = 3) + 
      theme_minimal()
  })
  
  output$table <- renderTable({
    data_df <- brushedPoints(mtcars, input$brush, xvar = 'wt', yvar = 'mpg')
    data_df[, c("mpg", "wt", "carb", "cyl")]
  })
}

shinyApp(ui, server)

# Zooming with the brush --------------------------------------------------

ui <- fluidPage(
  fluidRow(
    column(6, plotOutput("scatter", brush = 'plot_brush')),
    column(6, plotOutput("zoom"))
  )
)

server <- function(input, output){
  output$scatter <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point(colour = 'steelblue', size = 3) + 
      theme_minimal()
  })
  
  output$zoom <- renderPlot({
    ggplot(mtcars, aes(x = wt, y = mpg)) +
      geom_point(colour = 'steelblue', size = 3) + 
      theme_minimal() + 
      coord_cartesian(
        xlim = c(input$plot_brush$xmin, input$plot_brush$xmax),
        ylim = c(input$plot_brush$ymin, input$plot_brush$ymax)
      )
  })
 
}

shinyApp(ui, server)


# Coordinated plots -------------------------------------------------------

ui <- fluidPage(
  fluidRow(
    column(6, plotOutput("p1", brush = 'plot_brush')),
    column(6, plotOutput("p2"))
  )
)

server <- function(input, output){
  
  selected <- reactive({
    brushedPoints(mtcars, input$plot_brush, xvar = 'wt', yvar = 'mpg')
  })
  
  make_plot <- function(xvar, yvar, highlight){
    gp1 <- ggplot(mtcars, aes(x = .data[[xvar]], y = .data[[yvar]])) +
      geom_point(colour = 'steelblue', size = 2) + 
      theme_minimal()
    
    if (nrow(highlight > 0)){
      gp1 <- gp1 + geom_point(data = highlight, colour = 'red', size = 3)
    }
    
    gp1
  }
  
  output$p1 <- renderPlot(
    make_plot("wt", "mpg", selected())
  )
  
  output$p2 <- renderPlot(
    make_plot("hp", "mpg", selected())
  )
}

shinyApp(ui, server)

