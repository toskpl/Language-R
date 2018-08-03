## prosty shiny
## plik csv po wybraniu wyswietla sie zawartosc pliku csv
## jesli kolumna jest numercyzna wyświetla sie odoatkowo histogram

library(shiny)
library(ggplot2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Wybierz plik CSV",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      ),
      uiOutput("myList")
    ),
    mainPanel(
      plotOutput("myPlot"),
      tableOutput("myTable")
    )
  )
)


server <- function(input, output) {
  outListValue <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    dane <- read.csv(inFile$datapath, header = TRUE)
    vars <- sapply(dane, is.numeric)
    
    items=names(vars[vars])
    names(items)=items
    return(items)
  })
  
  output$myList <- renderUI({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    selectInput("to", "Wybierz z listy:",outListValue())
  })
  
  output$myPlot <- renderPlot({
    inFile <- input$file1
    if (is.null(inFile) || is.null(input$to))
      return(NULL)
    dane <- read.csv(inFile$datapath, header = TRUE)
    df = data.frame (dane)
    ggplot(df, aes_string( input$to)) +
      geom_histogram( )+
      ggtitle("Histogram")+
      ylab("Ilość")
    
  }) 
  
  output$myTable <- renderTable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath, header = TRUE)
  })
} 

shinyApp(ui, server)

