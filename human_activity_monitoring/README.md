# Shiny App Human Activity Monitoring documentation

This documentation provides a general guide to use the shiny app [Human Activity Monitoring](https://vondacho.shinyapps.io/human_activity_monitoring/).

## Where and How to Run the App

To run and use this app, one can consider the following different ways.

### Go to the website hosted by **shinyapps.io** of Rstudio

The website is [https://vondacho.shinyapps.io/human_activity_monitoring/](https://vondacho.shinyapps.io/human_activity_monitoring/).

### Run the app locally using command `runApp()`

If one has the code `ui.R` and `server.R` of the app locally with `shiny` package loaded, simply run the command `runApp(appDir)`, where `appDir` is a directory containing `server.R`, plus, either `ui.R` or a www directory that contains the file index.html.

### Run the app locally using command `runGitHub()`

The app has been uploaded on Github at [https://github.com/vondacho/coursera-datascience-data-products/tree/master/human_activity_monitoring](https://github.com/vondacho/coursera-datascience-data-products/tree/master/human_activity_monitoring).

One can run the shiny app by typing the command `runGitHub("https://github.com/vondacho/coursera-datascience-data-products/tree/master/human_activity_monitoring")` in R.



## Description of the App

### Dataset exploration

In a first tab this app proposes a simple exploration through the HAR dataset provided by [http://groupware.les.inf.puc-rio.br/har](http://groupware.les.inf.puc-rio.br/har). Users can select a member of the group of people engaged for the experimentation and one of the four captors used for the measures. The appl presents a reactive 3d scatter plot using the Plotly library and a summary of the filtered data. 

### Activity prediction

In a second tab this app proposes a simple prediction tool based on an model previously built and embedded into the deployment unit. The model is loaded at the start of the app. Users can submit the simulated values of the captors and get a class of activity as a prediction result.

This part is still under construction. The R code for the prediction can be found on GitHub at [https://github.com/vondacho/coursera-datascience-data-products/tree/master/human_activity_monitoring/prediction.R](https://github.com/vondacho/coursera-datascience-data-products/tree/master/human_activity_monitoring/prediction.R)



































