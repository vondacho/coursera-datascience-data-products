library(shiny)
library(plotly)
library(caret)

loadData <- function() {
    read.csv("https://vondacho.github.io/coursera-datascience-data-products/human_activity_monitoring/dataset-har-PUC-Rio-ugulino.csv",
        na.strings = c("NA",""), sep= ";")
}

makePlot <- function(data_har, user, captorId) {
    if (captorId == 1)
        plot_ly(data = data_har[data_har$user == user,], x = ~x1, y = ~y1, z = ~z1, color = ~class)
    else if (captorId == 2)
        plot_ly(data = data_har[data_har$user == user,], x = ~x2, y = ~y2, z = ~z2, color = ~class)
    else if (captorId == 3)
        plot_ly(data = data_har[data_har$user == user,], x = ~x3, y = ~y3, z = ~z3, color = ~class)
    else if (captorId == 4)
        plot_ly(data = data_har[data_har$user == user,], x = ~x4, y = ~y4, z = ~z4, color = ~class)
}

makeTable <- function(data_har, userId, captorId) {
    if (captorId == 1)
        df <- data_har %>% filter(user == userId) %>% select(user, body_mass_index, x1,y1,z1, class)
    else if (captorId == 2)
        df <- data_har %>% filter(user == userId) %>% select(user, body_mass_index, x2,y2,z2, class)
    else if (captorId == 3)
        df <- data_har %>% filter(user == userId) %>% select(user, body_mass_index, x3,y3,z3, class)
    else if (captorId == 4)
        df <- data_har %>% filter(user == userId) %>% select(user, body_mass_index, x4,y4,z4, class)
    
    data.frame(unclass(summary(df)), check.names = FALSE, stringsAsFactors = FALSE)
}

loadModelFit <- function() {
    readRDS("./human_activity_monitoring_model.rds")
}

predictClass <- function(model, body_mass_index, x1,y1,z1, x2,y2,z2, x3,y3,z3, x4,y4,z4) {
    predict(model, data.frame(
        c(body_mass_index),
        c(x1),c(y1),c(z1),
        c(x2),c(y2),c(z2),
        c(x3),c(y3),c(z3),
        c(x4),c(y4),c(z4))
    )
} 

shinyServer(
    function(input, output, session) {
        withProgress(message = 'Loading data', style = 'old', value = 0.1, {
            data_har = loadData()
        })
        
        output$captorPlotTitle <- renderPrint({"hello!"})
        
        output$captorPlot <- renderPlotly({
            progress <- shiny::Progress$new(style = 'old')
            progress$set(message = "Plotting data", value = 0.5)
            on.exit(progress$close())
            
            makePlot(data_har, input$user, input$captorId) %>% 
                add_markers() %>%
                layout(
                    scene = list(xaxis = list(title = 'x'),
                                 yaxis = list(title = 'y'),
                                 zaxis = list(title = 'z')))
        })
        
        output$table <- renderTable({
            makeTable(data_har, input$user, input$captorId)
        })
    }
)