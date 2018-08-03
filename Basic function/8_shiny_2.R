# - dashboard ze zbioru mtcars
# - w wybierałce daj wartości liczby biegów występujące w zbiorze
# - na wykresie umieść tylko dane o samochodach mających wybraną liczbę biegów
# - na osi x umieść liczbę mil przejeżdżanych na jednym galonie paliwa
# - na osi y umieść czas potrzebny na przejechanie ćwierci mili

library(shiny)
library(ggplot2)
library(dplyr)

gears = sort(unique(mtcars$gear))

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput('gears', 'Liczba biegów', gears)
    ),
    mainPanel(
      plotOutput('plot')
    )
  )
)

srv <- function(input, output){
  output$plot <- renderPlot({
    d = mtcars %>% filter(gear == input$gears)
    
    ggplot(d, aes(mpg, qsec)) +
      geom_point() +
      geom_smooth(se = F) +
      xlab("Liczba mil na galon") +
      ylab("Czas na ćwierć mili [s]")
  })
}

shinyApp(ui, srv)