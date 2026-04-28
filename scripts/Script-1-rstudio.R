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
