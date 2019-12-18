
library(shiny)
library(readr)

#load aggregated datasets

flights_airport_agg = read_csv("flights_airport.csv")
flights_airline_agg = read_csv("flights_airline.csv")

train_year_agg = read_csv("train_year.csv")
train_station_agg = read_csv("train_station.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Shiny Dashboard"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
           navlistPanel(tabPanel("SNCF Trains",
                                 tabsetPanel(tabPanel("agg",
                                                      tabsetPanel(tabPanel("year",
                                                                           #selection to control variable
                                                                           selectInput(inputId="train_year", label = "variable", choices= c("total_trips","num_departure_delays","num_arrival_delays",
                                                                                                                      "avg_num_departure_delays","avg_num_arrival_delays",
                                                                                                                      "total_depart_delay","total_arrival_delay",
                                                                                                                      "avg_depart_delay", "avg_arrival_delay",
                                                                                                                      "num_trains_cancelled","percent_cancelled",
                                                                                                                      "delay_external", "delay_infrastructure", "delay_traffic",
                                                                                                                      "delay_stock","delay_station","delay_travelers")
                                                                                       ),
                                                                           
                                                                           plotOutput("year_train_agg_plot")
                                                                           
                                                                           
                                                                           ),
                                                                  
                                                                  
                                                                  tabPanel("station",
                                                                           selectInput(inputId="train_station", label = "variable", choices= c("total_trips","num_departure_delays","num_arrival_delays",
                                                                                                                                            "avg_num_departure_delays","avg_num_arrival_delays",
                                                                                                                                            "total_depart_delay","total_arrival_delay",
                                                                                                                                            "avg_depart_delay", "avg_arrival_delay",
                                                                                                                                            "num_trains_cancelled","percent_cancelled",
                                                                                                                                            "delay_external", "delay_infrastructure", "delay_traffic",
                                                                                                                                            "delay_stock","delay_station","delay_travelers")
                                                                                        ),
                                                                           
                                                                                       plotOutput("station_train_agg_plot")
                                                                           )
                                                                    )
                                                    
                                                     )
                                    )           
                        ),
                        
                        tabPanel("Flights",
                                 tabsetPanel(
                                 
                                     tabPanel("airline",
                                              #selection to control variable
                                              selectInput(inputId="flights_airline", label = "variable", choices= c("flight_count",
                                                                                                                    "delay_count",
                                                                                                                    "avg_duration",
                                                                                                                    "avg_distance",
                                                                                                                    "total_distance",
                                                                                                                    "avg_depart_delay",
                                                                                                                    "avg_arrival_delay")
                                                        ),
                                              
                                              
                                                    plotOutput("airline_flights_agg_plot")
                                              
                                              
                                              
                                     ),
                                     
                                     
                                     tabPanel("airport",
                                              selectInput(inputId="flights_airport", label = "variable", choices= c("flight_count",
                                                                                                            "delay_count",
                                                                                                            "avg_duration",
                                                                                                            "avg_distance",
                                                                                                            "total_distance",
                                                                                                            "avg_depart_delay",
                                                                                                            "avg_arrival_delay")
                                              ),
                                              
                                                plotOutput("airport_flights_agg_plot")
                                              
                                              
                                     ),
                                     #TODO get map working
                                     tabPanel("map")
                            
                                 )
                        )
                     
                                 
                    )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot")
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    output$year_train_agg_plot <- renderPlot({
        plot(train_year_agg[["year"]],train_year_agg[[input$train_year]], xlab="year", ylab=input$train_year)
    })
    
    output$station_train_agg_plot <- renderPlot({
        plot(factor(train_station_agg[["departure_station"]]),train_station_agg[[input$train_station]], xlab="station", ylab=input$train_station)
    })
    
    
    output$airport_flights_agg_plot <- renderPlot({
        plot(factor(flights_airport_agg[["airport"]]),flights_airport_agg[[input$flights_airport]], xlab="airport", ylab=input$flights_airport)
    })
    
    output$airline_flights_agg_plot <- renderPlot({
        plot(factor(flights_airline_agg[["airline"]]),flights_airline_agg[[input$flights_airline]], xlab="airport", ylab=input$flights_airline)
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
