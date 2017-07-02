library(caret)    

loadData <- function() {
    read.csv("./dataset-har-PUC-Rio-ugulino.csv", 
             na.strings = c("NA",""),
             as.is = T,
             sep = ";",
             dec = ",")
}

cleanData <- function(df) {
    har_data_$z4 <- as.integer(har_data_$z4)
    har_data_ <- har_data_[!is.na(har_data_$z4),]
    har_data_$class <- as.factor(har_data_$class)
    har_data_
}

har_data_ <- cleanData(loadData())[,6:19]

set.seed(7)
har_in_train <- createDataPartition(har_data_$class, p=0.8, list = F)
har_data_training <- har_data_[har_in_train,]
har_data_testing <- har_data_[-har_in_train,]

control <- trainControl(method = "cv", number = 5)
model_fit <- train(class ~ ., data = har_data_training, method = "rpart", trControl = control)
#model_fit <- train(class ~ ., data = har_data_training, method = "treebag", trControl = control)
#model_fit <- train(class ~ ., data = har_data_training, method = "rf", trControl = control)
model_fit$results

saveRDS(model_fit, "human_activity_monitoring_model.rds")

