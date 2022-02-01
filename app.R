library(shiny)
library(tidyverse)
library(sf)

reactlog::reactlog_enable()
options(shiny.maxRequestSize = 60 * 1024 ^ 2)

ui <- fluidPage(
  titlePanel("Cálculo de distância"),
  sidebarLayout(
    sidebarPanel(
      fileInput(
        "file", 
        label = NULL, 
        accept = ".gpkg", 
        buttonLabel = "Selecione .gpkg..."
      ),
      actionButton(
        "calc", 
        label = "Iniciar cálculo", 
        icon = icon("fas fa-cogs")
      ),
      downloadButton("download_gpkg", label = "Download .gpkg"),
      downloadButton("download_csv", label = "Download .csv")
    ),
    mainPanel(
      h3("Amostra do arquivo:"),
      tableOutput("sample")
    )
  )  
)

server <- function(input, output, session) {
  file_read <- reactive({
    req(input$file)
    
    ext <- tools::file_ext(input$file$name)
    
    shinyFeedback::feedbackWarning("file", ext != "gpkg", "Formato inválido!")
    
    st_read(input$file$datapath)
  })
  
  calc_results <- eventReactive(input$calc, {
    id <- showNotification(
      "Calculando ...",
      duration = NULL,
      closeButton = FALSE
    )
    on.exit(removeNotification(id), add = TRUE)
    
    data <- file_read() %>% 
      create_linestring() %>% 
      calc_dist()
  })
  
  calc_csv <- reactive({
    calc_results() %>% transform_csv()
  })
  
  output$sample <- renderTable({
      req(calc_csv())
      calc_csv() %>% head(n = 10)
    }
  )
  
  output$download_gpkg <- downloadHandler(
    filename = function() {
      paste0(input$upload, "resultado.gpkg")
    },
    content = function(file) {
      st_write(calc_results(), file)
    }
  )
  
  output$download_csv <- downloadHandler(
    filename = function() {
      paste0(input$upload, "resultado.csv")
    },
    content = function(file) {
      st_write(calc_csv(), file)
    }
  )
}

shinyApp(ui, server)