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


# Radio buttons -----------------------------------------------------------

ui <- fluidPage(
  radioButtons("distribution", "Select a probability distribution",
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


# Checkbox group ----------------------------------------------------------

ui <- fluidPage(
  checkboxGroupInput("variables", "Variables to display", 
                     choices = c("mpg", "cyl", "wt", "drat", "hp"),
                     selected = c("wt", "hp")
  ),
  tableOutput("mtcars")
)

server <- function(input, output){
  output$mtcars <- renderTable({
    req(input$variables)
    head(mtcars[,input$variables])
  })
}

shinyApp(ui, server)


# Action button -----------------------------------------------------------


ui <- fluidPage(
  actionButton("resample", "Generate new sample"),
  plotOutput("scatter")
)

server <- function(input, output){
  output$scatter <- renderPlot(
  {
   input$resample
   x <- rnorm(50)
   y <- rnorm(50)
   plot(x, y)
  }
  )
}

shinyApp(ui, server)


# Data table --------------------------------------------------------------

ui <- fluidPage(
  dataTableOutput("mytable")
)

server <- function(input, output){
  output$mytable <- renderDataTable(mtcars)
}

shinyApp(ui, server)



# Verbatim/code formatted text ------------------------------------------------

ui <- fluidPage(
  radioButtons("variable", "Select a variable", choices = colnames(mtcars)),
  verbatimTextOutput("variable_summary")
)

server <- function(input, output){
  output$variable_summary <- renderPrint(summary(mtcars[[input$variable]]))
}

shinyApp(ui, server)

# Pretty printed text -----------------------------------------------------

ui <- fluidPage(
  radioButtons("variable", "Select a variable", choices = colnames(mtcars)),
  p("The mean is", textOutput("variable_mean", inline = TRUE), ". ")
)

server <- function(input, output){
 output$variable_mean <- renderText(round(mean(mtcars[[input$variable]]), 2)) 
}

shinyApp(ui, server)



# Sidebar layout ----------------------------------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
      sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
      sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
      sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15),     
    ),
    mainPanel(
      plotOutput("histogram")
    )
  )
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

# Sidebar layout (flipped left/right) -----------------------------------------

ui <- fluidPage(
  sidebarLayout(
    mainPanel(
      plotOutput("histogram")
    ),
    sidebarPanel(
      sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
      sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
      sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
      sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15),     
    )
  )
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


# Sidebar layout (main panel less wide) ---------------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
      sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
      sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
      sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15), 
      width = 2
    ),
    mainPanel(
      plotOutput("histogram"), width = 4
    )
  )
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

# Sidebar layout with fluid row in main panel --------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
      sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
      sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
      sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15)
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("histogram")),
        column(6, verbatimTextOutput("summary"))
      )
    )
  )
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
  
  output$summary <- renderPrint({
      data_df <- tibble(x = rnorm(n = input$n, mean = input$mean, sd = input$sd))    
      summary(data_df$x)
  })
}

shinyApp(ui, server)

# Reactivity with reactive ----------------------------------------------------

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of histogram bins", min = 10, max = 100, step = 10, ticks = FALSE, value = 40),
      sliderInput("n", "Sample size", min = 1000, max = 10000, value = 2500),
      sliderInput("mean", "Mean of normal distribution", min = 50, max = 150, value = 100),
      sliderInput("sd", "Std dev of the normal distribution", min = 5, max = 50, value = 15)
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("histogram")),
        column(6, verbatimTextOutput("summary"))
      )
    )
  )
)

server <- function(input, output){
  samples <- reactive({
    rnorm(n = input$n, mean = input$mean, sd = input$sd)
  })
  
  output$histogram <- renderPlot(
    {
      data_df <- tibble(x = samples())
      ggplot(data_df, aes(x = x)) + 
        geom_histogram(bins = input$bins, color = 'white') + 
        theme_classic()
    }
  )
  
  output$summary <- renderPrint({
      summary(samples())
  })
}

shinyApp(ui, server)


# dependent selectors -----------------------------------------------------

datasets <- list(
  mtcars = mtcars, # or else e.g. mtcars = read_csv("....")
  iris = iris,
  airquality = airquality
)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput('dataset', "Select the data set", choices =  names(datasets)),
      selectInput("xvar", "Select the x variable", choices = NULL),
      selectInput("yvar", "Select the y variable", choices = NULL),
      width = 4
    ),
    mainPanel(
     plotOutput("scatter") ,
     width = 8
    )
  )
)

server <- function(input, output, session){
  
  observeEvent(input$dataset, {
    
    # only numeric columns can be selected
    cols <- datasets[[input$dataset]] |> select(where(is.numeric)) |> colnames()
    
    # i.e. that which was selected by selectInput("dataset", ....)
    updateSelectInput(session, "xvar", choices = cols, selected = cols[1])
    updateSelectInput(session, "yvar", choices = cols, selected = cols[2])
  }
  )
  
  output$scatter <- renderPlot({
    # xvar and yvar must not be NULL
    req(input$xvar, input$yvar)
    # xvar and yvar must be in the selected dataset
    # 
    req(input$xvar %in% names(datasets[[input$dataset]]),
        input$yvar %in% names(datasets[[input$dataset]]))
    data_df <- datasets[[input$dataset]]
    ggplot(data_df, aes(x = .data[[input$xvar]], y = .data[[input$yvar]])) + 
      geom_point()
  })
}

shinyApp(ui, server)
