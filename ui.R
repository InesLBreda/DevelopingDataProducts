library(shiny); library(DT)

shinyUI(fluidPage(
    titlePanel("Developing Data Products"),
    sidebarLayout(
        sidebarPanel(
            h3("Assignment"),
            h4("15 august 2019"),
            em("Ines L Breda")
        ),
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Data Preview",
                                 h5("This data set provides measurements of the diameter, height and volume of timber in 31 felled black cherry trees. Note that the diameter (in inches) is erroneously labelled Girth in the data. It is measured at 4 ft 6 in above the ground."),
                                 br(),
                                 DT::dataTableOutput("mytable")
                        ),
                        tabPanel("Discover the data",
                                 fixedRow(
                                     column(5,
                                            br(),
                                            br(),
                                            br(),
                                            radioButtons("x", "Select variable:",
                                                         list("Girth"='Girth', "Height"='Height', "Volume"='Volume'))
                                     ),
                                     column(5,
                                            br(),
                                            plotOutput("plot2") 
                                     )
                                 )
                        ),
                        tabPanel("Interactive Linear Model",
                                 fixedRow(
                                     column(5,
                                            br(),
                                            br(), 
                                            h5("Please select an area of data points in the plot."),
                                            br(),
                                            h5("Slope"),
                                            textOutput("slopeOut"),
                                            h5("Intercept"),
                                            textOutput("intOut")
                                     ),
                                     column(5,
                                            plotOutput("plot1", brush = brushOpts(id = "brush1"))
                                     ))
                        )
            )
        )
    )
)
)

