# Make sure this is done first. Get the token etc from shinyapps.io
# rsconnect::setAccountInfo(name='mark-andrews',
#                           token='xxxxx',
#                           secret='xxxx')

# A demo app to use -------------------------------------------------------

library(shiny)
library(readr)
library(ggplot2)

data_df <- read_csv("weight.csv")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("point_colour", 
                   "Point colour", 
                   choices = c("steelblue", "red", "brown", "violet"),
                   selected = 'red'),
      sliderInput("point_size", "Point size", min = 0.5, max = 5, value = 1)
    ),
    mainPanel(
      plotOutput("scatter")
    )
  )
)


server <- function(input, output){
  output$scatter <- renderPlot({
    ggplot(data_df, aes(x = height, y = weight)) +
      geom_point(size = input$point_size, colour = input$point_colour) +
      theme_classic()
  })
}

shinyApp(ui, server)
ui <- fluidPage(
  sliderInput("n", "The number of points", min = 10, max = 100, value = 55),
  plotOutput("scatter")
)
