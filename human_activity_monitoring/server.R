loadData <- function() {
    read.csv("./dataset-har-PUC-Rio-ugulino.csv", 
             na.strings = c("NA",""),
             as.is = T,
             sep = ";",
             dec = ",")
}

cleanData <- function(har_data) {
    har_data$z4 <- as.integer(har_data$z4)
    df <- har_data[!is.na(har_data$z4),]
    df$class <- as.factor(df$class)
    df
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

shinyServer(
    function(input, output, session) {
        withProgress(message = 'Loading data', style = 'old', value = 0.1, {
            data_har <- loadData()
            setProgress(0.2)
            data_har <- cleanData(data_har)
            setProgress(0.3)
            model_fit <- loadModelFit()
            setProgress(0.5)
        })

        output$captorPlot <- renderPlotly({
            progress <- shiny::Progress$new(style = 'old')
            progress$set(message = "Plotting data", value = 0.75)
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
        
        output$prediction <- reactive({
            predict(model_fit, data.frame(
                body_mass_index = input$body_mass_index,
                x1=input$x1, y1=input$y1, z1=input$z1,
                x2=input$x2, y2=input$y2, z2=input$z2,
                x3=input$x3, y3=input$y3, z3=input$z3,
                x4=input$x4, y4=input$y4, z4=input$z4))
        })
    }
)