###################################################
### Dodatkowe materiały
###################################################

# http://shiny.rstudio.com/tutorial/
# http://shiny.rstudio.com/gallery/widget-gallery.html


# install.packages('shiny') 

library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel('Rozkład normalny:'),
  sidebarLayout(
    sidebarPanel(
      h3("Wybierałka:"),
      sliderInput("mean", "Ustaw średnią", -100, 100, 0, step = 0.001),
      sliderInput("sd", "Ustaw odch. st.", 1, 100, 1, step = 0.001)
    ),
    mainPanel(
      h3("Wykres:"),
      plotOutput('plot'),
      verbatimTextOutput('txt')
    )
  )
)

srv <- function(input, output){
  output$txt <- renderPrint({
    paste0('Mean: ',input$mean,' SD: ',input$sd)
  })
  
  output$plot <- renderPlot({
    min_x = input$mean - 5 * input$sd
    max_x = input$mean + 5 *  input$sd
    x = seq(min_x, max_x, length.out = 1000)
    y = dnorm(x, input$mean, input$sd)
    
    ggplot(mapping = aes(x,y)) +
      geom_line()
  })
}

shinyApp(ui, srv)