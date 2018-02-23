library(shinythemes)
library(shiny) 
library(DT)


ui <- fluidPage(theme = shinytheme("sandstone"),
  
  titlePanel("Movies Recommendation Path"),
  
  sidebarLayout(position = "left",
                sidebarPanel(
                  
                  helpText("Find the optimal movies path."),
                  
                  selectInput("var1", 
                              label = "Choose a first movie",
                              choices =  movies_used$original_title),
                  
                  selectInput("var2", 
                              label = "Choose a second movie",
                              choices =  movies_used$original_title),
                  
                  br(), 
                  
                  br(),
                  
                  helpText("Get the similarities between two movies."),
                  
                  selectInput("var3", 
                              label = "First movie",
                              choices =  movies_used$original_title),
                  
                  selectInput("var4", 
                              label = "Second movie",
                              choices =  movies_used$original_title)
                  
                  
                ),
                
                mainPanel(
                  
                  
                  tabsetPanel(
                    tabPanel("Path", br(), helpText("The optimal path between those movies is"),DT::dataTableOutput("mytable")), 
                    tabPanel("Similarities",br(), helpText("The keywords in common for the two movies are"),textOutput("keywords"),
                             br(), helpText("The genres in common for the two movies are"),textOutput("genre"))
                  )
                  
                  
                )
  )
)

server <- function(input, output) {
  

  
  output$keywords <- renderText({ similarities(c(input$var3, input$var4), tmdb, matrix_movies2)
  })
  
  output$genre <- renderText({ similarities(c(input$var3, input$var4), tmdb, matrix_movies)
  })
  
  output$mytable = DT::renderDataTable({
    movies_path(c(input$var1,input$var2), tmdb, graph)
  })
  
  
  
}

shinyApp(ui = ui, server = server)

