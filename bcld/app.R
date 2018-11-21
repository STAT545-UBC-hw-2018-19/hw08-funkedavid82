library(shiny)
#library(tidyverse)
library(ggplot2)
library(dplyr)
library(stringr)
library(DT)
library(shinythemes)
#library(rsconnect)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- fluidPage(
  theme = shinytheme("cerulean"),
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      img(src="bcl_store.jpg", width = "100%"), #an image of the BC Liquor Store to the UI
      br(), br(),
      sliderInput("priceInput", "Price range", 0, 100, c(25, 40), pre = "$"), # Add slider to the sidebar panel that allows  user select a price range:
      checkboxGroupInput("typeInput", "Select product type", #to choose more than one product type.
                         choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                         selected = "WINE"), # Add radio buttons to the sidebar panel that allows user select their alcohol type:
      checkboxInput("sortInput", "Sort results by price", # an option to sort the results table by price.
                    value= FALSE,
                    width= NULL),
      # checkboxInput("sweetsortInput", "Sort Wine by sweetness", # an option to sort the results table by sweetness of wine.
      #               value= FALSE,
      #               width= NULL),
      # conditionalPanel( # the sweetness slider shows up whenever Wine is chosen.
      #   condition = "input.typeinput == 'WINE'",
      #   sliderInput("sweet", "Wine by Sweetness Level", 0, 10, c(2,5))),
      
      
      #     colourpicker::colourInput("color", "Choose colour", "#629151"), #Add choice of color to the plot
      uiOutput("countryOutput")
    ),
    mainPanel(
      h3(textOutput("Sum_results")), #Show the number of results found whenever the filters change.
      downloadButton("Download", "Download Results"), #the code here allows the user to download the results table as a ..csv file.
      br(), br(),
      tabsetPanel( #this command places the plot and table in two different windows.
        tabPanel("Plot", plotOutput("coolplot")),
        tabPanel("Result Table", DT::dataTableOutput("results"))#Use the DT package to turn the current results table into an interactive table. 
        
      )
      
    )
  )
)

server <- function(input, output) {
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Filter by country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })  
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }
    if (input$sortInput) {
      bcl %>%
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type %in% input$typeInput, #to choose more than one product type.
               Country == input$countryInput) %>%
        arrange(Price)
    } else {
      bcl %>%
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type %in% input$typeInput, #to choose more than one product type.
               Country == input$countryInput)  
    }
    
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content, fill = Type)) +
      geom_histogram(colour = "black") + #colour according to product type.
      scale_x_continuous() +
      theme_bw() +
      labs(x="Alcohol Content", y="Number of Product")
  })
  
  output$results <- DT::renderDataTable({ #Use the DT package to turn the current results table into an interactive table. 
    if (input$sortInput==TRUE) { #output the sorted price in the rendered table.
      filtered() %>%
        arrange(Price)
    }
    # else if (input$sortInput==TRUE & input$sweetsortInput==FALSE) { #output the sorted price in the rendered table and the sorted sweetness if wine is chosen
    #   filtered() %>%
    #     arrange(Price)
    # }
    # else if (input$sortInput==FALSE & input$sweetsortInput==TRUE) { #output the sorted price in the rendered table and the sorted sweetness if wine is chosen
    #   filtered() %>%
    #     arrange(Price) %>%
    #     filter(Sweetness >= input$sweet[1],
    #            Sweetness <= input$sweet[2])
    # }
    else filtered()
  })
  
  output$Sum_results <- renderText({ #the chunk code here shows the number of results found whenever the filters change.
    paste0("We found ", nrow(filtered()), " option(s) for you")
  })
  
  output$Download <- downloadHandler( # the code allows the user to download the results table as a ..csv file.
    filename = function(){
      "bcl-data.csv"
    },
    content = function(resultingData){
      write.csv(filtered(),resultingData)
    }
  )
}

shinyApp(ui = ui, server = server)
