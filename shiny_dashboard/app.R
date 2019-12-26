
library(shiny)
library(readr)
library(ggplot2)

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
        mainPanel(
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
                        ),
                        tabPanel("documentation",mainPanel(
                          h1("R Final Project"),
                          h2("Data set"),
                          p("Our Main goal is to study two datasets. The first one contain various information about the train in France from 2015 to 2018.
                            The information are mainly about stations, date and cancellation. The second dataset, describe 2015 flights giving a huge number 
                            of indication about airports, date, distance and delay."),
                          h2("Preprocess treatment"),
                          p("As we begin with raw data and in order to develop a cleaner application, we preprocess in an other file the raw data.We compute 
                            different aggregation on the preprocess.Rmd file."),
                          p("Then we finally write a CSV file, which contain all the data we have juste process in order to have a better response time when
                            using the application. To generate the dashboard, we don't have to do any calculation, we just load the preprocess file"),
                          h2("The dashboard"),
                          p("We create a shiny application to visualise all the data, We can choose two types of dataset that we want to visualise :"),
                          h3("SNCF train"),
                          p("For the SNCF train, we propose two kind of visualisation :"),
                          div(HTML("<h4>Year & Station</h4>
<p>For both of them we can visualise the following information : </p>
<ul>
  <li>total trips</li>
  <li>number of departure delays</li>
  <li>number of arrival delays</li>
  <li>average number of departure delays</li>
  <li>average number of arrival delays</li>
  <li>total departure delay</li>
  <li>total arrival delay</li>
  <li>average departure delay</li>
  <li>average arrival delay</li>
  <li>percent of cancelledtrains</li>
  <li>external delay</li>
  <li>infrastructure delay</li>
  <li>traffic delay</li>
  <li>stock delay</li>
  <li>station delay</li>
  <li>travelers delay</li>
</ul>")),
                          
                          h3("flights"),
                          p("For flights we provide a map visualisation and also two other kind : "),
                          div(HTML("<h4>Airline & Airport</h4>
<p>For both of them we can visualise the following information :</p>
<ul>
  <li>flight count</li>
  <li>delay count</li>
  <li>average duration</li>
  <li>average distance</li>
  <li>total distance</li>
  <li>average departure delay</li>
  <li>average arrival delay</li>
</ul>")),
                          
                        
                          )
                          )
                     
                                 
                    )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #plotOutput("plot")
            
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    output$year_train_agg_plot <- renderPlot({
        ggplot(train_year_agg, aes(x=year, y=train_year_agg[[input$train_year]])) + geom_bar(stat="identity", color='darkblue', fill="blue") +ylab(input$train_year)
      
        #plot(train_year_agg[["year"]],train_year_agg[[input$train_year]], xlab="year", ylab=input$train_year)
    })
    
    output$station_train_agg_plot <- renderPlot({
      ggplot(train_station_agg, aes( x=departure_station, y = train_station_agg[[input$train_station]]) )  + geom_bar(stat="identity", color='darkblue', fill="blue") +ylab(input$train_station)
      #plot(factor(train_station_agg[["departure_station"]]),train_station_agg[[input$train_station]], xlab="station", ylab=input$train_station)
    })
    
    
    output$airport_flights_agg_plot <- renderPlot({
      ggplot(flights_airport_agg, aes(x=airport, y=flights_airport_agg[[input$flights_airport]]))  + geom_bar(stat="identity", color='darkblue', fill="blue") +ylab(input$flights_airport)  
      #plot(factor(flights_airport_agg[["airport"]]),flights_airport_agg[[input$flights_airport]], xlab="airport", ylab=input$flights_airport)
    })
    
    output$airline_flights_agg_plot <- renderPlot({
      ggplot(flights_airline_agg, aes(x=airline, y=flights_airline_agg[[input$flights_airline]]))  + geom_bar(stat="identity", color='darkblue', fill="blue") +ylab(input$flights_airline)    
      #plot(factor(flights_airline_agg[["airline"]]),flights_airline_agg[[input$flights_airline]], xlab="airport", ylab=input$flights_airline)
    })
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
