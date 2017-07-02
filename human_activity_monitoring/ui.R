# Define UI for application that draws a histogram
shinyUI(
    navbarPage("Human activity monitoring",
       tabPanel("Dataset exploration",
            fluidRow(
                column(3,
                       selectInput("user", "User:",
                                   c("Debora" = "debora",
                                     "Jose-Carlos" = "jose_carlos",
                                     "Katia" = "katia",
                                     "Wallace" = "wallace")),
                       selectInput("captorId", "Captor:",
                                   c("Captor 1" = "1",
                                     "Captor 2" = "2",
                                     "Captor 3" = "3",
                                     "Captor 4" = "4"))),
                column(9,
                       plotlyOutput("captorPlot"))),
            fluidRow(
                column(12, offset = 1,
                       tableOutput("table")))
       ),
       tabPanel("Activity prediction",
            fluidRow(
                column(3,
                    h4("Captor 1"),
                    sliderInput("x1",label = "x", min = -500, max = 500, value = 0),
                    sliderInput("y1",label = "y", min = -500, max = 500, value = 0),
                    sliderInput("z1",label = "z", min = -500, max = 500, value = 0),
                    h4("Body mass index"),
                    sliderInput("body_mass_index",label = "index", min = 0, max = 50, value = 25)),
                column(3,
                    h4("Captor 2"),
                    sliderInput("x2",label = "x", min = -500, max = 500, value = 0),
                    sliderInput("y2",label = "y", min = -500, max = 500, value = 0),
                    sliderInput("z2",label = "z", min = -500, max = 500, value = 0)),
                column(3,
                    h4("Captor 3"),
                    sliderInput("x3",label = "x", min = -500, max = 500, value = 0),
                    sliderInput("y3",label = "y", min = -500, max = 500, value = 0),
                    sliderInput("z3",label = "z", min = -500, max = 500, value = 0)),
                column(3,
                    h4("Captor 4"),
                    sliderInput("x4",label = "x", min = -500, max = 500, value = 0),
                    sliderInput("y4",label = "y", min = -500, max = 500, value = 0),
                    sliderInput("z4",label = "z", min = -500, max = 500, value = 0))),
       fluidRow(
           column(12,
                  h4("Activity class prediction"),
                  textOutput("prediction")))
    ))
)
