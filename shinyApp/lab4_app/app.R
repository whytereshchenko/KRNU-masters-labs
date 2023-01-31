library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Характеристики діамантів"),
  sidebarLayout(
    sidebarPanel(  
      selectInput("select", h3("вибрати характеристику"), 
                  choices = names(diamonds), 
                  selected = 1),
      
    ),
    mainPanel(
      plotOutput("hist"),
      dataTableOutput("table")
    )
  )
)

server <- function(input, output, session) {
  
  data_2 <- reactive(get(input$select, diamonds)) # реактивний датасет
  
  output$table <- renderDataTable({
    diamonds %>% 
      arrange(desc(carat)) %>%
      head(100) %>%
      select(carat, cut, color, price)
  }, options = list(pageLength = 5))
  
  output$hist <- renderPlot({
    diamonds %>% 
      ggplot( aes(data_2())) + geom_bar()})
}

shinyApp(ui = ui, server = server)
